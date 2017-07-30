(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package gruvbox-theme
  :ensure t
  :config (load-theme 'gruvbox-dark-soft t)
  )

(use-package helm-core
  :ensure t)
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x f" . helm-recentf)
	 ("C-SPC" . helm-dabbrev)
	 ("C-x b" . helm-buffers-list))
  :config (progn
	    (setq helm-buffers-fuzzy-matching t)
	    (helm-mode 1)))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  ;; More configuration goes here
  )

(setq inhibit-startup-screen t)

(tool-bar-mode -1)

(set-face-attribute 'default nil :height 160)
