set -o errexit
set -o pipefail
set -o nounset

ZOTERO_DIR="$HOME/Zotero"
ZOTERO_DB="${ZOTERO_DIR}/zotero.sqlite"

OPENER="xdg-open"

# All-in-one previewer copied from https://github.com/MarrekNozka/fzf--previewer
PREVIEWER="$HOME/.dotfiles/scripts/opener.sh"
SEPARATOR="\t"

# SELECTOR=(rofi
# 	-normal-window
# 	-dmenu -i
# 	-sort
# 	-display-column-separator
# 	"$SEPARATOR"
# )
#
SELECT="zotero://select/items/@"
#
SELECTOR=(
	fzf
	--header-lines 1
	--layout "reverse"
	--delimiter "$SEPARATOR"
	--info "default"
	--with-nth "1,2,4"
	--preview "$PREVIEWER {5}"
	--preview-label "[ Preview ]"
	--bind "enter:become(echo {3})"
	--bind "ctrl-s:become($OPENER zotero://select/items/@{2})"
	--ansi
)

COPIED_DB=""
if ! sqlite3 "$ZOTERO_DB" "select * from items;" 2>/dev/null; then
	# the database is locked (5) by Zotero probably.
	COPIED_DB="$ZOTERO_DB.tmp.sqlite"
	cp "$ZOTERO_DB" "$COPIED_DB"
	ZOTERO_DB="$COPIED_DB"
fi

# AI-generated spaghetti
QUERY="\
 WITH ranked_attachments AS (
    SELECT
        value as value,
        attachmentItems.key,
        itemAttachments.contentType,
        STRING_AGG(
            NULLIF(CONCAT(creators.firstName, ' ', creators.lastName), ' '),
            '; '
        ) OVER (PARTITION BY items.itemID) as creators,
        CONCAT(
            '${ZOTERO_DIR}/storage/',
            attachmentItems.key,
            '/',
            REPLACE(
                SUBSTRING(itemAttachments.path, 9), -- Remove 'storage:' prefix
                '/',
                '\/'
            )
        ) as transformed_path,
        -- Get citation key from itemData
        (
        SELECT SUBSTRING(idv.value, 15, 66)
              --SUBSTRING(citation_data.value, POSITION('Citation Key: ' IN citation_data.value) + 13) as citation_key,
            FROM itemData id
            JOIN itemDataValues idv ON id.valueID = idv.valueID
            WHERE id.itemID = items.itemID 
            AND id.fieldID = (
                SELECT fieldID 
                FROM fields 
                WHERE fieldName = 'extra'
            )
            AND idv.value LIKE 'Citation Key:%'
        ) as citation_key,
        ROW_NUMBER() OVER (
            PARTITION BY items.itemID 
            ORDER BY 
                CASE 
                    WHEN itemAttachments.contentType = 'application/pdf' THEN 1 
                    ELSE 2 
                END,
                attachmentItems.dateAdded
        ) as attachment_rank
    FROM items
    LEFT JOIN itemData ON itemData.itemID = items.itemID
    LEFT JOIN itemCreators ON itemCreators.itemID = items.itemID
    LEFT JOIN creators ON creators.creatorID = itemCreators.creatorID
    LEFT JOIN itemDataValues ON itemData.valueID = itemDataValues.valueID
    LEFT JOIN itemAttachments ON itemAttachments.parentItemID = items.itemID
    LEFT JOIN libraries ON libraries.libraryID = items.libraryID
    LEFT JOIN items attachmentItems ON attachmentItems.itemID = itemAttachments.itemID
    WHERE itemData.fieldID = 1
        AND libraries.type = 'user'
        AND itemAttachments.path LIKE 'storage:%'
)
SELECT 
    value,
    citation_key,
    key,
    creators,
    transformed_path
FROM ranked_attachments
WHERE attachment_rank = 1
ORDER BY value;
"

RESULT="$(sqlite3 --separator "$SEPARATOR" --readonly "$ZOTERO_DB" "$QUERY")"
# echo $RESULT

# Format the results
FORMATED="Press enter to open PDF, CTRL-S to show in zotero\n$RESULT"
FORMATED=$(
	echo -e "$FORMATED" |
		awk 'BEGIN{FS="\t"} \
      NR==1{print $0; next} \
      # Wrap with ANSI bold yellow \
      {print "\033[1;33m" $1 "\033[0m" FS $2 FS $3 FS $4 FS $5}'
)

# Get the selection and open the file
SELECTED=$(
	echo -e "$FORMATED" | "${SELECTOR[@]}"
)

# Use zotero URI scheme to use built-in PDF/html viewer
SELECTED_PATH="zotero://open-pdf/library/items/$SELECTED"
# echo -e "$SELECTED_PATH"

if [[ "$COPIED_DB" != "" ]]; then
	rm $COPIED_DB
fi

$OPENER "$SELECTED_PATH"
