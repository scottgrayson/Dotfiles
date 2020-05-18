;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

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
(setq doom-theme 'doom-solarized-light)
;; (package! doom-themes :ignore t)
;; (package! plan9-theme)
;; (require 'plan9-theme)
;; (load-theme 'plan9 t)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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

(use-package dimmer
  :config
  (setq dimmer-fraction 0.2)
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

(use-package php-mode
  :config
  (setq c-basic-offset 4)
  (add-hook 'php-mode-hook 'php-enable-psr2-coding-style)
  )

(use-package phpunit
  :config
  ;; (setq phpunit-stop-on-error t)
  ;; (setq phpunit-stop-on-failure t)
  (define-key php-mode-map (kbd "M-t t") 'phpunit-current-test)
  (define-key php-mode-map (kbd "M-t c") 'phpunit-current-class)
  (define-key php-mode-map (kbd "M-t p") 'phpunit-current-project)
  (define-key php-mode-map (kbd "M-t M-t") 'phpunit-current-test)
  (define-key php-mode-map (kbd "M-t M-c") 'phpunit-current-class)
  (define-key php-mode-map (kbd "M-t M-p") 'phpunit-current-project)
  )

(add-hook 'php-mode-hook
          '(lambda ()
             ;; (require 'company-php)
             ;; (company-mode t)
             ;; (ac-php-core-eldoc-setup) ;; enable eldoc
             (make-local-variable 'company-backends)
             (add-to-list 'company-backends 'company-ac-php-backend)))

(use-package js2-mode
  :config
  (setq js2-basic-offset 4)
  )

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
 "o" 'ace-link
 "b" 'ivy-switch-buffer
 "k" 'which-key-show-top-level
 "f" 'counsel-projectile-find-file
 "F" 'counsel-file-jump
 "." 'ivy-resume
 "r" 'anzu-query-replace
 ;; "\\" 'evil-sp-override
 "R" 'anzu-query-replace-at-cursor
 "w" 'save-buffer
 "p" 'switch-to-previous-buffer
 "t" 'ac-php-find-symbol-at-point
 "(" 'ac-php-location-stack-back
 ")" 'ac-php-location-stack-forward
 "[" 'dumb-jump-back
 "]" 'dumb-jump-go
 "i" 'indent-and-untabify
 "s" 'counsel-rg
 "l" 'avy-goto-line
 "u" 'string-inflection-all-cycle
 "g" nil
 "gl" 'magit-log-buffer-file
 "gb" 'magit-blame
 "gp" 'magit-browse-pull-request
 "gf" 'browse-at-remote
 "y" nil
 "ye" 'aya-expand
 "yc" 'aya-create
 "yo" 'aya-create-one-line
 "yn" 'yas-new-snippet
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
(map! "M-w" 'ace-window)

(general-define-key
 :keymaps '(override)
 "C-c p" 'projectile-command-map)
