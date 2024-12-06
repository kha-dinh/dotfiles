set -o errexit
set -o pipefail
set -o nounset

ZOTERO_DIR="$HOME/Zotero"
ZOTERO_DB="${ZOTERO_DIR}/zotero.sqlite"

PDF_READER="xdg-open"
# PDF_READER="evince"

# SELECTOR="rofi -normal-window -dmenu -i -sort -display-column-separator '|'"
SELECTOR="fzf --with-nth 1 --delimiter '@'"
# SELECTOR="fzf"

COPIED_DB=""
if ! sqlite3 $ZOTERO_DB "select * from items;" 2>/dev/null; then
	# the database is locked (5) by Zotero probably.
	COPIED_DB="$ZOTERO_DB.tmp.sqlite"
	cp $ZOTERO_DB $COPIED_DB
	ZOTERO_DB="$COPIED_DB"
fi

QUERY=$(sqlite3 -separator '@' $ZOTERO_DB "
WITH ranked_items AS (
    SELECT 
        value,
        attachmentItems.key,
        itemAttachments.contentType,
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
        CASE 
            WHEN itemAttachments.contentType = 'application/pdf' THEN 1
            ELSE 2
        END as content_type_rank
    FROM items
    LEFT JOIN itemData ON itemData.itemID = items.itemID
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
    key,
    transformed_path
FROM ranked_items
ORDER BY content_type_rank, value;
-- SELECT value, attachmentItems.key, 
-- CONCAT(
--         '${ZOTERO_DIR}/storage/',
--         attachmentItems.key,
--         '/',
--         REPLACE(
--             SUBSTRING(itemAttachments.path, 9), -- Remove 'storage:' prefix (8 chars + 1)
--             '/',
--             '\/'
--         )
--     ) as transformed_path
-- FROM items
-- LEFT JOIN itemData ON itemData.itemID = items.itemID
-- LEFT JOIN itemDataValues ON itemData.valueID = itemDataValues.valueID
-- LEFT JOIN itemAttachments ON itemAttachments.parentItemID = items.itemID
-- LEFT JOIN libraries ON libraries.libraryID = items.libraryID
-- LEFT JOIN items attachmentItems ON attachmentItems.itemID = itemAttachments.itemID
-- WHERE itemData.fieldID = 1
--     AND libraries.type = 'user'
--     AND itemAttachments.path LIKE 'storage:%'
--     AND itemAttachments.contentType = 'application/pdf';
-- SELECT value
-- FROM items
-- LEFT JOIN itemData, itemDataValues, itemAttachments, items attachmentItems
-- WHERE itemData.itemID = items.itemID
--     AND itemData.fieldID = 1
--     AND itemData.valueID = itemDataValues.valueID
--     AND itemAttachments.path LIKE 'storage:%'
--     AND itemAttachments.parentItemID = items.itemID
--     AND attachmentItems.itemID = itemAttachments.itemID
--     AND itemAttachments.contentType = 'application/pdf';
")
# QUERY="value@key\n$QUERY"
SELECTED_KEY=$(
	echo -e "$QUERY" |
		# column --table -c 120 -T 1 --separator '@' |
		fzf --header-lines 1 --border --with-nth=1,2 --delimiter '@' --preview='/home/khadd/.dotfiles/scripts/opener.sh {3}' --bind 'enter:become(echo {2})'
)

# printf "$SELECTED_NAME\n"
# SELECTED_PATH=$(sqlite3 $ZOTERO_DB "
# SELECT attachmentItems.key, itemAttachments.path
# FROM items
# LEFT JOIN itemData, itemDataValues, itemAttachments, items attachmentItems
# WHERE itemData.itemID = items.itemID
#     AND value = '${SELECTED_NAME}'
#     AND itemData.fieldID = 1
#     AND itemData.valueID = itemDataValues.valueID
#     AND itemAttachments.path LIKE 'storage:%'
#     AND itemAttachments.parentItemID = items.itemID
#     AND attachmentItems.itemID = itemAttachments.itemID
#     -- AND itemAttachments.contentType = 'application/pdf';
# " | tail --lines=1)
# SELECTED_PATH="${ZOTERO_DIR}/storage/${SELECTED_PATH/|storage:/\/}"

SELECTED_PATH="zotero://open-pdf/library/items/$SELECTED_KEY"
echo $SELECTED_PATH

if [[ "$COPIED_DB" != "" ]]; then
	rm $COPIED_DB
fi

$PDF_READER "$SELECTED_PATH"
