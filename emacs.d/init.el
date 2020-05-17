;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq vc-follow-symlinks t)

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-search-module (quote evil-search))
 '(org-agenda-files (quote ("~/hunting_seasons.org" "~/org/gcal.org")))
 '(org-export-backends (quote (ascii html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (forge string-inflection reformatter transient magit ghub treepy use-package elm-mode sudo-edit simple-mpc haskell-mode evil-smartparens visual-regexp dimmer smex esup ialign ace-link auto-package-update auto-yasnippet evil-org expand-region evil-matchit browse-at-remote yasnippet-snippets whitespace-cleanup-mode which-key web-mode sqlup-mode sql-indent spaceline smartparens slack rainbow-mode rainbow-delimiters plan9-theme phpunit org-plus-contrib org-gcal org-bullets magithub kaolin-themes js2-mode ivy-rich ivy-hydra indent-guide hungry-delete groovy-mode git-gutter general flycheck exec-path-from-shell evil-surround evil-nerd-commenter evil-mu4e evil-magit evil-indent-textobject evil-ediff evil-collection emmet-mode dumb-jump diminish counsel-projectile company-php calfw-org calfw-ical calfw-gcal calfw beacon ace-window ac-php)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
