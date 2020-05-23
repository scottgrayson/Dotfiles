;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; doom dashboard png
;; (setq +doom-dashboard-banner-dir "/Users/scottgrayson/.doom.d/doom-dashboard/banners/")
(setq +doom-dashboard-banner-dir "/Users/scottgrayson/Code/dotfiles/doom.d/banners/")
(setq +doom-dashboard-banner-file "emacs.svg")
;;
;; never open new workspace
(setq +workspaces-on-switch-project-behavior nil)
;; split window thresholds
(setq split-height-threshold nil)
(setq split-width-threshold 100)


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Scott Grayson"
      user-mail-address "dscottgrayson@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one-light)
;; (setq doom-theme 'doom-city-lights)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-nord-light)
;; (setq doom-theme 'doom-nord)
;; (setq doom-theme 'doom-nova)
;; (setq doom-theme 'doom-opera)
;; (setq doom-theme 'doom-solarized-dark)
;; (setq doom-theme 'doom-solarized-light)
;; (setq doom-theme 'doom-spacegrey)
;; (setq doom-theme 'doom-wilmersdorf)
;; (package! doom-themes :ignore t)
(require 'plan9-theme)
(load-theme 'plan9 t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(use-package js2-mode
  :config
  (setq js2-basic-offset 4)
  )

(use-package ace-link
  :config
  (ace-link-setup-default)
  )

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  )

(use-package writeroom-mode
  :config
  (setq writeroom-maximize-window t)
  (setq writeroom-restore-window-config t)
  )

(use-package ace-window
  :config
  (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9))
  )

(use-package dimmer
  :config
  (setq dimmer-fraction 0.4)
  (setq dimmer-watch-frame-focus-events nil)
  (setq dimmer-adjustment-mode ':foreground)
  (dimmer-mode)
  )

(use-package avy
  :config
  (setq avy-case-fold-search nil)
  (setq avy-background t)
  (setq avy-keys '(
                   ?t ?n ?s ?e ?r ?i ?o ?a ?p ?l ?f ?u ?c ?,
                   ?v ?d ?h ?y ?w ?. ?x ?' ?\; ?q ?j ?g ?/
                   ))
  )

(use-package phpunit
  :config
  ;; (setq phpunit-stop-on-error t)
  ;; (setq phpunit-stop-on-failure t)
  (define-key +php-laravel-mode-map (kbd "M-t t") 'phpunit-current-test)
  (define-key +php-laravel-mode-map (kbd "M-t c") 'phpunit-current-class)
  (define-key +php-laravel-mode-map (kbd "M-t p") 'phpunit-current-project)
  (define-key +php-laravel-mode-map (kbd "M-t M-t") 'phpunit-current-test)
  (define-key +php-laravel-mode-map (kbd "M-t M-c") 'phpunit-current-class)
  (define-key +php-laravel-mode-map (kbd "M-t M-p") 'phpunit-current-project)
  )

(add-hook 'php-mode-hook
          '(lambda ()
             ;; (require 'company-php)
             ;; (company-mode t)
             ;; (ac-php-core-eldoc-setup) ;; enable eldoc
             (make-local-variable 'company-backends)
             (add-to-list 'company-backends 'company-ac-php-backend)))

(use-package web-mode
  :config
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-script-padding 0)
  (setq web-mode-style-padding 0)
  (setq web-mode-comment-style 2)
  (setq-default indent-tabs-mode nil)
  (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))
  (add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
  (setq web-mode-engines-alist
        '(
          ("php"  . "\\.phtml\\'")
          ("blade"  . "\\.blade\\.")
          ))
  )

;; custom functions

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-and-untabify ()
  (interactive)
  (untabify (point-min) (point-max))
  (indent-buffer))

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
          Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))



;; Keybinds
;;TODO use doom's map! instead of using general directly

(general-override-mode)

(general-define-key
 :keymaps '(evil-window-map)
 "q" 'evil-window-delete
 "s" 'evil-window-vsplit
 "S" 'evil-window-split
 "c" 'ace-swap-window
 "x" 'evil-window-delete
 "n" 'evil-window-next
 "u" 'winner-undo
 "r" 'winner-redo
 "a" 'balance-windows
 "o" 'delete-other-windows
 "SPC" 'ace-window)

(defun evil-nohl ()
  (interactive)
  (evil-ex-nohighlight))

(general-define-key
 :keymaps 'insert
 ;; "DEL" 'hungry-delete-backward
 "M-e" 'emmet-expand-line
 "C-e" 'yas-expand
 )

(general-define-key
 :keymaps 'help-map
 "y" 'yas-describe-tables
 )

(general-define-key
 :states '(normal visual)
 :keymaps '(override)
 "RET" 'evil-nohl
 ;; "," 'evil-repeat-find-char-reverse
 "(" 'git-gutter:previous-hunk
 ")" 'git-gutter:next-hunk
 "[" 'flycheck-previous-error
 "]" 'flycheck-next-error
 "#" 'evilnc-comment-or-uncomment-lines
 ;; "&" 'er/expand-region
 "s" 'avy-goto-word-1
 "S" 'avy-goto-char)

(general-define-key
 :states '(normal visual)
 :keymaps '(override)
 "SPC" nil
 )

(setq my-leader1 "SPC")
(general-define-key
 :prefix my-leader1
 :states '(normal motion)
 :keymaps '(override)
 "!" nil
 "#" nil
 "$" nil
 "%" nil
 "&" nil
 "'" nil
 "(" 'ac-php-location-stack-back
 ")" 'ac-php-location-stack-forward
 "*" nil
 "," nil
 "." 'ivy-resume
 "/" nil
 ";" nil
 "=" nil
 "@" nil
 "F" 'counsel-file-jump
 "R" 'anzu-query-replace-at-cursor
 "RET" nil
 "SPC" nil
 "[" 'dumb-jump-back
 "\\" nil
 "]" 'dumb-jump-go
 "^" nil
 "`" nil
 "a" nil
 "b" 'ivy-switch-buffer
 "c" 'org-capture
 "d" 'deft
 "e" nil
 "f" 'counsel-projectile-find-file
 "g" nil
 "gg" 'magit-status
 "gb" 'magit-blame
 "gf" 'browse-at-remote
 "gl" 'magit-log-buffer-file
 "gp" 'magit-browse-pull-request
 "gs" 'magit-status
 "h" nil
 "i" 'indent-and-untabify
 "k" 'counsel-yank-pop
 "l" 'avy-goto-line
 "m" 'avy-goto-line
 "n" nil
 "o" 'writeroom-mode
 "p" 'switch-to-previous-buffer
 "q" nil
 "r" 'anzu-query-replace
 "s" 'counsel-rg
 "t" 'ac-php-find-symbol-at-point
 "u" 'string-inflection-all-cycle
 "v" 'ace-link
 "w" 'save-buffer
 "x" nil
 "y" nil
 "yc" 'aya-create
 "ye" 'aya-expand
 "yn" 'yas-new-snippet
 "yo" 'aya-create-one-line
 "z" 'undo-tree-visualize
 "{" nil
 "}" nil
 ;; "n p" 'visit todo for project
 ;; "n t" 'visit todo
 )

(general-define-key
 :keymaps 'company-active-map
 :states 'normal
 "SPC" 'ignore)

(evil-define-minor-mode-key 'normal 'org-src-mode
  (kbd "C-c r") 'nil
  (kbd "C-c e") 'nil
  (kbd "SPC w") 'nil
  )

(map! "C-c g" 'magit-status)
(map! "M-g" 'magit-status)
(map! "M-w" 'ace-window)

(general-define-key
 :keymaps '(override)
 "C-c p" 'projectile-command-map)
