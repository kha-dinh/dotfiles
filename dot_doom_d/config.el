;;; config.el -*- lexical-binding: t; -*-

(setq-default delete-by-moving-to-trash t                      ; Delete files to trash
              window-combination-resize t                      ; take new window space from all other windows (not just current)
              tab-width 4                                                         ; Set width for tabs
              uniquify-buffer-name-style 'forward      ; Uniquify buffer names
              x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 40000000                         ; Raise undo-limit to 40Mb
      undo-outer-limit 4000000                         ; Raise undo-limit to 4Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t      ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(display-time-mode 1)                             ; Enable time in the mode-line
(delete-selection-mode 1)                             ; Replace selection when inserting text
(global-subword-mode 1)                           ; Iterate through CamelCase words

(if (equal "Battery status not available"
           (battery))
    (display-battery-mode 1)                        ; On laptops it's nice to know how much power you have
  (setq password-cache-expiry nil))               ; I can trust my desktops ... can't I? (no battery = desktop)

(setq user-full-name "Dinh Duy Kha"
      user-mail-address "dalo2903@gmail.com")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)
(use-package! solaire-mode
  :config
  (setq solaire-mode-auto-swap-bg nil)
  )
(use-package! nyan-mode
  :config
  (setq nyan-wavy-trail t
        nyan-animation-frame-interval 0.1)
  (nyan-mode)
  (nyan-start-animation))
(global-visual-line-mode)
(setq-default visual-fill-column-center-text t)
(setq display-line-numbers-type 'relative)

(after! centaur-tabs
  ;; (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-style "wave")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-height 36)

  )

(use-package! ranger
  :config (setq ranger-override-dired 'ranger))

(defvar my-completion-delay 0)

(use-package! lsp-mode
  ;; :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024)
        treemacs-space-between-root-nodes nil
        lsp-idle-delay my-completion-delay ;; clangd is fast
        lsp-headerline-breadcrumb-enable t
        )
  (setq lsp-clients-clangd-args '("-j=3"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--completion-style=detailed"
                                  "--header-insertion=never"
                                  "--header-insertion-decorators=0"))
  (after! lsp-clangd (set-lsp-priority! 'clangd 2))
  )

(after! company
  :config
  (setq
   company-idle-delay my-completion-delay
   company-show-numbers t
   company-minimum-prefix-length 1)
  (add-to-list 'company-backends #'company-tabnine)
  (add-to-list 'company-backends #'company-capf)

  (map!
   :map company-active-map
   ("<tab>" 'company-complete-selection)
   ("RET" 'company-complete-selection)

   )
  ;; (add-hook 'evil-normal-state-entry-hook #'company-abort)
  )

(map! :leader
      :prefix "f"
      :desc "find other file" "o" 'ff-find-other-file
      )

;; (setq +format-with-lsp nil)
;; (setq c-default-style "user")

(require 'llvm-mode)
(require 'tablegen-mode)

;; c;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; TODO: Clean up
(setq org-roam-directory "~/org/roam/")
(setq deft-directory "~/org/")
(use-package! org
  :hook (org-mode . +org-pretty-mode)
  :init
  (setq org-directory "~/org/")
  ;; (setq org-agenda-files "~/Dropbox/org/" )
  )
(setq org-ref-completion-library 'org-ref-ivy-cite)

(use-package! websocket
  :after org-roam)
(after! org-roam
  (defun my/org-id-update-org-roam-files ()
    "Update Org-ID locations for all Org-roam files."
    (interactive)
    (org-id-update-id-locations (org-roam-list-files)))

  (defun my/org-id-update-id-current-file ()
    "Scan the current buffer for Org-ID locations and update them."
    (interactive)
    (org-id-update-id-locations (list (buffer-file-name (current-buffer))))))
;;
(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))
;;
(setq deft-recursive t)
;; (add-hook! org-mode +org-pretty-mode)
(setq reftex-default-bibliography "~/org/bibliography/bibliography.bib")
(after! bibtex
  (setq bibtex-autokey-year-length 4
        bibtex-autokey-name-year-separator "-"
        bibtex-autokey-year-title-separator "-"
        bibtex-autokey-titleword-separator "-"
        bibtex-autokey-titlewords 2
        bibtex-autokey-titlewords-stretch 1
        bibtex-autokey-titleword-length 5
        org-ref-bibtex-hydra-key-binding (kbd "H-b"))
  )

(after! org-ref-ivy
  (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
        org-ref-insert-cite-function 'org-ref-cite-insert-ivy
        org-ref-insert-label-function 'org-ref-insert-label-link
        org-ref-insert-ref-function 'org-ref-insert-ref-link
        org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body)))
  )
(use-package! ivy-bibtex
  :init
  (setq
   bibtex-completion-bibliography '("~/org/bibliography/bibliography.bib")
   bibtex-completion-notes-path "~/org/bibliography/notes/"
   bibtex-completion-pdf-field "file"
   bibtex-completion-display-formats
   '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
     (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
     (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
   bibtex-completion-notes-template-multiple-files
   (concat
    "#+TITLE: ${title}\n"
    "#+ROAM_KEY: ${=key=}\n"
    "* TODO Notes\n"
    ":PROPERTIES:\n"
    ":Custom_ID: ${=key=}\n"
    ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
    ":AUTHOR: ${author-abbrev}\n"
    ":JOURNAL: ${journaltitle}\n"
    ":DATE: ${date}\n"
    ":YEAR: ${year}\n"
    ":DOI: ${doi}\n"
    ":URL: ${url}\n"
    ":END:\n\n"
    )
   )
  )
;; (use-package! org-roam-bibtex
;;   :after (org-roam)
;;   :hook (org-roam-mode . org-roam-bibtex-mode)
;;   :config
;;   (setq org-roam-bibtex-preformat-keywords
;;         '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
;;   (setq orb-templates
;;         '(("r" "ref" plain (function org-roam-capture--get-point)
;;            ""
;;            :file-name "${slug}"
;;            :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}\n#+ROAM_TAGS:

;; - keywords :: ${keywords}

;; \n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-abbrev}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

;;            :unnarrowed t))))
(after! org-noter
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   org-noter-separate-notes-from-heading t
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path (list "~/org/bibliography/notes/")
   )
  (map!
   :map org-noter-doc-mode-map
   :leader
   :desc "Insert note"
   "n i" #'org-noter-insert-note
   :desc "Insert precise note"
   "n p" #'org-noter-insert-precise-note
   :desc "Go to previous note"
   "n <" #'org-noter-sync-prev-note
   :desc "Go to next note"
   "n >" #'org-noter-sync-next-note
   :desc "Create skeleton"
   "n ." #'org-noter-create-skeleton
   :desc "Kill session"
   "n q" #'org-noter-kill-session
   )

  )
(after! org-capture
  ;; Firefox and Chrome
  (add-to-list 'org-capture-templates
               '("P" "Protocol" entry ; key, name, type
                 (file+headline +org-capture-notes-file "Inbox") ; target
                 "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"
                 :prepend t ; properties
                 :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("L" "Protocol Link" entry
                 (file+headline +org-capture-notes-file "Inbox")
                 "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n"
                 :prepend t
                 :kill-buffer t))
  )
(org-babel-do-load-languages
 'org-babel-load-languages
 '((gnuplot . t)))
(setq org-image-actual-width '(800))

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "import" nil nil nil filename)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

(add-to-list 'image-file-name-extensions "pdf")
(setq imagemagick-types-inhibit (remove 'PDF imagemagick-types-inhibit))
(setq org-image-actual-width 600)

;; (setq lsp-latex-forward-search-args
;; '("--eval"
;;   "(lsp-latex-forward-search-with-pdf-tools \"%f\" \"%p\" \"%l\")")
;; )
(setq +latex-viewers '(okular pdf-tools))
(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)
;; (add-hook! LaTeX-mode
;;   (setq TeX-auto-save t
;;         TeX-parse-self t
;;         TeX-save-query nil
;;         TeX-source-correlate-start-server t
;;         TeX-PDF-mode t
;;         TeX-source-correlate-method 'synctex
;;         reftex-plug-into-AUCTeX t
;;         +latex-viewers '(pdf-tools zathura)
;;         )
;;   )
;; (add-hook! LaTeX-mode lsp)

(global-set-key (kbd "M-;") 'comment-dwim-2)
(map! :leader
      :desc "Toggle delete other windows" "1" 'zygospore-toggle-delete-other-windows
      :desc "Vertical split" "2"  'evil-window-split
      :desc "Vertical split" "3"  'evil-window-vsplit
      :desc "Vertical split" "0"  'ace-delete-other-windows
      :desc "Kill buffer" "k" 'kill-this-buffer
      :desc "Previous buffer" "[" 'previous-buffer
      :desc "Next buffer" "]" 'next-buffer
      )
(global-set-key (kbd "C-s") 'save-buffer)

(defhydra hydra-dired (:hint nil :color pink)
  "
_+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
_C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
_D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
_R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
_Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
_S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
_r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
_z_ compress-file  _A_ find regexp
_Z_ compress       _Q_ repl regexp

T - tag prefix
"
  ("\\" dired-do-ispell)
  ("(" dired-hide-details-mode)
  (")" dired-omit-mode)
  ("+" dired-create-directory)
  ("=" diredp-ediff)         ;; smart diff
  ("?" dired-summary)
  ("$" diredp-hide-subdir-nomove)
  ("A" dired-do-find-regexp)
  ("C" dired-do-copy)        ;; Copy all marked files
  ("D" dired-do-delete)
  ("E" dired-mark-extension)
  ("e" dired-ediff-files)
  ("F" dired-do-find-marked-files)
  ("G" dired-do-chgrp)
  ("g" revert-buffer)        ;; read all directories again (refresh)
  ("i" dired-maybe-insert-subdir)
  ("l" dired-do-redisplay)   ;; relist the marked or singel directory
  ("M" dired-do-chmod)
  ("m" dired-mark)
  ("O" dired-display-file)
  ("o" dired-find-file-other-window)
  ("Q" dired-do-find-regexp-and-replace)
  ("R" dired-do-rename)
  ("r" dired-do-rsynch)
  ("S" dired-do-symlink)
  ("s" dired-sort-toggle-or-edit)
  ("t" dired-toggle-marks)
  ("U" dired-unmark-all-marks)
  ("u" dired-unmark)
  ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
  ("w" dired-kill-subdir)
  ("Y" dired-do-relsymlink)
  ("z" diredp-compress-this-file)
  ("Z" dired-do-compress)
  ("q" nil)
  ("." nil :color blue))
;; (define-key dired-mode-map "." 'hydra-dired/body)
(map!
 :map dired-mode-map
 ("." 'hydra-dired/body)
 )

(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-tail-mode))
(add-to-list 'auto-mode-alist '("\\.terminal\\'" . auto-revert-tail-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . auto-revert-tail-mode))

(defun etc-log-tail-handler ()
  (end-of-buffer)
  (make-variable-buffer-local 'auto-revert-interval)
  (setq auto-revert-interval 1)
  (auto-revert-set-timer)
  (make-variable-buffer-local 'auto-revert-verbose)
  (setq auto-revert-verbose nil)
  (read-only-mode t)
  (font-lock-mode 0)
  (when (fboundp 'show-smartparens-mode)
    (show-smartparens-mode 0)))

(add-hook 'auto-revert-tail-mode-hook 'etc-log-tail-handler)

(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(defun x11-yank-image-at-point-as-image ()
  "Yank the image at point to the X11 clipboard as image/png."
  (interactive)
  (let ((image (get-text-property (point) 'display)))
    (if (eq (car image) 'image)
        (let ((data (plist-get (cdr image) ':data))
              (file (plist-get (cdr image) ':file)))
          (cond (data
                 (with-temp-buffer
                   (insert data)
                   (call-shell-region
                    (point-min) (point-max)
                    "xclip -i -selection clipboard -t image/png")))
                (file
                 (if (file-exists-p file)
                     (start-process
                      "xclip-proc" nil "xclip"
                      "-i" "-selection" "clipboard" "-t" "image/png"
                      "-quiet" (file-truename file))))
                (t
                 (message "The image seems to be malformed."))))
      (message "Point is not at an image."))))

(use-package! lsp-grammarly
  :hook (text-mode . (lambda ()
                       (add-to-list 'lsp-language-id-configuration '(org-mode . "plaintext"))
                       (lsp))))  ; or lsp-deferred