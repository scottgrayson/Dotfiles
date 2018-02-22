
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-search-module (quote evil-search))
 '(package-selected-packages
   (quote
    (company-php ac-php php-extras exec-path-from-shell js2-mode vue-mode flycheck yasnippet-snippets which-key web-mode use-package symon sudo-edit spaceline solarized-theme rainbow-mode rainbow-delimiters projectile plan9-theme php-mode org-bullets minimal-theme magithub leuven-theme hydra gruvbox-theme git-gutter general evil-surround evil-magit evil-indent-textobject emmet-mode diminish dashboard counsel company beacon avy))))
