;; Initialize package manager
(require 'package)
(setq package-archives
      (list ("melpa" . "https://melpa.org/packages/")
            ("elpa" . "https://elpa.gnu.org/packages/")))
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
