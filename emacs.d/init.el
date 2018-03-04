
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives
	     '(("gnu" . "https://elpa.gnu.org/packages/")
	     ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-mode t)
 '(custom-safe-themes
   (quote
    ("ef1e992ef341e86397b39ee6b41c1368e1b33d45b0848feac6a8e8d5753daa67" "107693012b59b3a94faa869756333b8fe7224670f762ce97eb1dda89f03f5bcd" default)))
 '(evil-search-module (quote evil-search))
 '(fci-rule-color "#f8fce8")
 '(hl-paren-background-colors (quote ("#e8fce8" "#c1e7f8" "#f8e8e8")))
 '(hl-paren-colors (quote ("#40883f" "#0287c8" "#b85c57")))
 '(package-selected-packages
   (quote
    (ivy-rich company-quickhelp whitespace-cleanup-mode evil-nerd-commenter evilnc indent-guide hungry-delete dumb-jump ivy-hydra counsel-projectile "sqlup-mode" "sqlup-mode" "sqlup-mode" sqlup sqlup-mode sql-indent groovy-mode yasnippet-snippets which-key web-mode use-package spaceline smartparens rainbow-mode rainbow-delimiters projectile plan9-theme phpunit org-bullets magithub kaolin-themes js2-mode hydra git-gutter general flycheck exec-path-from-shell evil-surround evil-magit evil-indent-textobject evil-collection emmet-mode diminish counsel company-php beacon ace-window ac-php)))
 '(sml/active-background-color "#98ece8")
 '(sml/active-foreground-color "#424242")
 '(sml/inactive-background-color "#4fa8a8")
 '(sml/inactive-foreground-color "#424242"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
