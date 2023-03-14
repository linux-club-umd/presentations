;; Initialize package manager
(require 'package)
(setq package-archives
      (list ("gnu" . "https://elpa.gnu.org/packages/")
	    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
	    ("melpa" . "https://melpa.org/packages/")))
;; Emacs 28+ includes gnu and nongnu by default, so this can be shortened to one line:
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
;; Download and install configured packages if they aren't already installed.
(setq use-package-always-ensure t)

(use-package ef-themes)
;; A nice dark theme. `'modus-operandi` is the light theme version.
;; You can change the theme with `M-x load-theme`.
;; You can pick from the ef-themes with `M-x ef-themes-select`.
(load-theme 'modus-vivendi)

(use-package cua-base
  :custom
  (cua-keep-region-after-copy t)
  :init
  (cua-mode))
