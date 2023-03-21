;; Initialize package manager
(require 'package)
(setq package-archives
      (list ("gnu" . "https://elpa.gnu.org/packages/")
            ("nongnu" . "https://elpa.nongnu.org/nongnu/")
            ("melpa" . "https://melpa.org/packages/")
            ))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
;; Download and install configured packages if they aren't already installed.
(setq use-package-always-ensure t)

(use-package ef-themes)
;; A nice dark theme. 'modus-operandi' is the light theme version.
;; You can change the theme while Emacs is running with `M-x load-theme`.
(load-theme 'modus-vivendi)

(use-package cua-base
  :custom
  (cua-keep-region-after-copy t)
  :init
  (cua-mode))

;; Save changes made with Emacs' Customize system to a different file,
;; so that there isn't strange code added to your init.el file.
;; Then, load this file to load customizations.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Record startup times of packages, useful for debugging
(setq use-package-compute-statistics t)
;; Emacs 28+ includes native compilation. If you get annoyed by the errors, uncomment the below line to log warnings without popping up the *Warnings* buffer.
; (native-comp-async-report-warnings-errors 'silent)

;; enable keybind support
;; you can run `M-x describe-personal-keybindings` to list custom keys'
(use-package bind-key)

;; delight hides entries from the modeline
;; useful for reducing clutter
(use-package delight)

;; Here we use a nice dark theme. `'modus-operandi` is the light theme version.
;; Some themes load Lisp code such as this one
;; Normally we want to read the Lisp code to ensure it is safe, but this theme is built-in, so ignoring this check is fine.
(load-theme 'modus-vivendi t)
;; The built-in modus themes have accessible colors for colorblind folks
;; ef-themes is another accessible palette which is installed
(use-package ef-themes)
;; You can change the theme with `M-x load-theme`.
;; You can pick from the modus-themes with `M-x modus-themes-select'.
;; You can pick from the ef-themes with `M-x ef-themes-select`.
;; You can change them interactively with `M-x consult-theme`.

;; Default cursor is a block, uncomment this if you want a bar
;; (setq cursor-type 'bar)

(use-package rainbow-delimiters
  ;; rainbow parentheses
  :hook prog-mode)

(use-package cua-base
  ;; Familiar undo/cut/copy/paste keys
  ;; To press Ctrl-X or Ctrl-C as part of a shortcut:
  ;; - type it quickly (within 0.2 seconds by default)
  ;; - press Ctrl-Shift-X or Ctrl-Shift-C
  :custom
  (cua-keep-region-after-copy t)
  (mouse-drag-and-drop-region t)
  :init
  (cua-mode))

(use-package gcmh
  ;; the Garbage Collector Magic Hack
  ;; By default Emacs collects a little garbage frequently, which can be slow.
  ;; The hack is to collect a lot of garbage infrequently (when Emacs is idle).
  ;; Disable this if your computer runs out of memory often.
  :delight
  :init (gcmh-mode))

;; The default undo limits for emacs are quite low.
;; On modern systems you may wish to use much higher limits.
;; Otherwise you might not be able to undo very far.
;; https://codeberg.org/ideasman42/emacs-undo-fu#undo-limits
(setq undo-limit 6710886400) ;; 64mb.
(setq undo-strong-limit 100663296) ;; 96mb.
(setq undo-outer-limit 1006632960) ;; 960mb.

;; Emacs yes-or-no questions require answering 'yes' or 'no' by default
;; Once you get the hang of Emacs, you can uncomment this to answer with 'y' or 'n' instead
;; (setq use-short-answers t)

(use-package windmove
  ;; Window movement
  :init
  ;; Press Alt-Arrow to move focus between windows by direction
  (windmove-default-keybindings 'meta)
  ;; Press Alt-Shift-Arrow to swap windows by direction
  (windmove-swap-states-default-keybindings '(shift meta))
  ;; Press C-x Alt-Arrow to delete windows by direction
  (windmove-delete-default-keybindings nil 'meta))

(use-package which-key
  ;; Show a list of commands and keybindings that can be executed from your current keypresses
  :init
  (which-key-mode))

(use-package expand-region
  ;; expand/contract selection from words/characters
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

(use-package orderless
  ;; completion style that matches patterns in any order
  ;; useful when you can't remember what `M-x` command you're looking for
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  ;; vertical completion UI
  :init
  (vertico-mode)
  (vertico-mouse-mode))

(use-package marginalia
  ;; annotate completion buffer
  :init
  (marginalia-mode))

(use-package consult
  ;; interactive search and navigation commands
  ;; very customizable, here we override some default keys
  ;; you can uncomment them if you like, commands are accessible via `M-x`
  :bind (("C-x b" . consult-buffer)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)))

;; icons!
(use-package all-the-icons)
(use-package all-the-icons-completion
  :after all-the-icons
  :init (all-the-icons-completion-mode))
(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; default behavior tabs instead of completing
(setq tab-always-indent 'complete)
;; default right-click menu
(context-menu-mode)
;; shift-click to select region
(bind-key (kbd "S-<down-mouse-1>") 'mouse-set-mark)
;; Ctrl+y and Ctrl+Shift+Z for redo
(bind-key (kbd "C-S-z") 'undo-redo)
(bind-key (kbd "C-y") 'undo-redo)
;; Send files to trash when deleting in Emacs
(setq delete-by-moving-to-trash t)
;; scroll only 1 line at a time
(setq scroll-conservatively most-positive-fixnum)
;; Use C-x C-f to open files and urls at point
(ffap-bindings)
;; remember recent files
(recentf-mode)

;; change backup file locations to ~/.emacs.d/aux/
(setq lock-file-name-transforms
      '(("\\`/.*/\\([^/]+\\)\\'" "~/.emacs.d/aux/\\1" t)))
(setq auto-save-file-name-transforms
      '(("\\`/.*/\\([^/]+\\)\\'" "~/.emacs.d/aux/\\1" t)))
(setq backup-directory-alist
      '((".*" . "~/.emacs.d/aux/")))

;; show line and column numbers in modeline
(column-number-mode)
(line-number-mode)
;; wrap visual lines
;; opinionated
;; (global-visual-line-mode)

(use-package whole-line-or-region
  ;; opinionated
  ;; use the default emacs clipboard shortcuts to cut/copy whole lines when there is no region
  ;; also affects the comment shortcut - Alt-; comments whole lines when there is no region, like Ctrl-x Ctrl-;
  :delight whole-line-or-region-local-mode
  :init (whole-line-or-region-global-mode))

(use-package corfu
  ;; Tab completion
  ;; https://elpa.gnu.org/packages/corfu.html#orgea2217e
  ;; TAB-and-Go customizations
  :custom
  (corfu-auto t)
  (corfu-cycle t)           ;; Enable cycling for `corfu-next/previous'
  (corfu-preselect 'prompt) ;; Always preselect the prompt

  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

;; Use Dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . hippie-expand))
  ;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))

;; ;; Enable Corfu completion UI
;; ;; See the Corfu README for more configuration tips.
;; (use-package corfu
;;   :init
;;   (global-corfu-mode))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

(use-package eglot
  ;; Emacs client for the Language Server Protocol
  ;; LSP servers must be installed separately
  ;; Default servers are listed in the 'eglot-server-programs' variable
  ;; This hook attempts to start automatically start eglot for code files
  :hook (prog-mode . eglot-ensure))
(setq completion-category-overrides '((eglot (styles orderless))))
;; (with-eval-after-load 'eglot
;; (setq completion-category-defaults nil))
;; https://emacs-lsp.github.io/lsp-mode/page/performance/#increase-the-amount-of-data-which-emacs-reads-from-the-process
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(use-package tree-sitter)
;; incremental parsing library
;; Emacs has historically used font-lock, a regular expression syntax highlighter
;; tree-sitter features faster, more colorful, and more accurate syntax highlighting
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(use-package tree-sitter-langs)

(use-package elec-pair
  ;; insert a closing paren when typing an opening paren
  ;; you can select a word and press a paren to surround it with that paren
  :hook (prog-mode . electric-pair-mode))

(use-package paren
  ;; highlight matching parens
  :hook (prog-mode . show-paren-mode))

(use-package mixed-pitch
  ;; don't use monospace fonts for reading/writing text
  :delight
  :hook
  (text-mode . mixed-pitch-mode))

(use-package anzu
  ;; show number of matches in search
  :delight
  :bind
  (("M-%" .  anzu-query-replace)
   ("C-M-%" . anzu-query-replace-regexp))
  :init
  (global-anzu-mode))

(use-package doom-modeline
  ;; use a fancy modeline from the Doom Emacs distribution
  :init
  (doom-modeline-mode))

(use-package treemacs)

(use-package dired-sidebar)
(define-key dired-mode-map (kbd "<mouse-2>") 'dired-find-alternate-file)

(use-package dired
  :custom
  (dired-listing-switches "-lah")
  (dired-recursive-copies 'top)
  (dired-recursive-deletes 'top))

(use-package diredfl
  :config
  (diredfl-global-mode))

;; zoom in/out
(bind-key (kbd "C-+") 'text-scale-increase)
(bind-key (kbd "C-_") 'text-scale-decrease)

(use-package default-text-scale
  ;; emacs 29 includes this functionality by default
  ;; C-M-= and C-M--
  :config
  (default-text-scale-mode))

