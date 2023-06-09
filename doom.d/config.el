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

(setq auth-sources '("~/.authinfo"))

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

(setq doom-font (font-spec :family "Iosevka" :size 16 :weight 'regular))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

(defun y/auto-update-theme ()
  "depending on time use different theme"
  (let* ((hour (nth 2 (decode-time (current-time))))
         (theme (cond ((<= hour 17)   'doom-solarized-light)
                      (t               'doom-solarized-dark-high-contrast))))
    (when (not (equal doom-theme theme))
      (setq doom-theme theme)
      (load-theme doom-theme t))
    ;; run that function again next hour
    (run-at-time (format "%02d:%02d" (+ hour 1) 0) nil 'y/auto-update-theme)))

;; uncomment for auto theme
;; (y/auto-update-theme)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! company
  :defer
  :config
  (setq company-idle-delay 0)
  )

(use-package! ace-link
  :defer
  :config
  (ace-link-setup-default)
  )

(use-package! writeroom-mode
  :defer
  :config
  (setq writeroom-maximize-window t)
  (setq writeroom-restore-window-config t)
  )

(use-package! ace-window
  :defer
  :config
  (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9))
  )

(use-package! lsp-mode
  :defer
  :config
  (setq lsp-enable-file-watchers nil)
  (setq lsp-auto-guess-root t)
  )

(use-package! dimmer
  :defer
  :config
  (setq dimmer-fraction 0.3)
  (setq dimmer-watch-frame-focus-events nil)
  (setq dimmer-adjustment-mode ':foreground)
  (dimmer-mode)
  )

(use-package! avy
  :defer
  :config
  (setq avy-case-fold-search nil)
  (setq avy-background t)
  (setq avy-keys '(
                   ?t ?n ?s ?e ?r ?i ?o ?a ?p ?l ?f ?u ?c ?,
                   ?v ?d ?h ?y ?w ?. ?x ?' ?\; ?q ?j ?g ?/
                   ))
  )

(use-package! phpunit
  :defer
  :config
  (setq phpunit-stop-on-error t)
  (setq phpunit-stop-on-failure t))

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
          Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; Keybinds
;;TODO use doom's map! instead of using general directly

(general-override-mode)

(general-define-key
 :states '(normal visual)
 :keymaps '(override)
 ;; "RET" 'evil-nohl
 ;; "," 'evil-repeat-find-char-reverse
 "SPC" nil
 "(" 'git-gutter:previous-hunk
 ")" 'git-gutter:next-hunk
 "[" 'flycheck-previous-error
 "]" 'flycheck-next-error
 "#" 'evilnc-comment-or-uncomment-lines
 "%" 'evilmi-jump-items
 ;; "&" 'er/expand-region
 "s" 'avy-goto-word-1
 "S" 'avy-goto-char)

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
 ;; "(" 'ac-php-location-stack-back
 ;; ")" 'ac-php-location-stack-forward
 "*" nil
 "," nil
 "." 'vertico-repeat
 "/" nil
 ";" nil
 "=" nil
 "@" nil
 "B" 'switch-to-buffer
 "F" nil
 "R" 'anzu-query-replace-at-cursor
 "RET" nil
 "SPC" nil
 "[" nil
 "\\" nil
 "]" nil
 "^" nil
 "`" nil
 "~" 'string-inflection-all-cycle
 "a" nil
 "b" 'projectile-switch-to-buffer
 "c" 'org-capture
 "d" 'deft
 "e" nil
 "f" 'projectile-find-file
 "g" nil
 "gg" 'magit-status
 "gb" 'magit-blame
 "gf" 'browse-at-remote
 "gl" 'magit-log-buffer-file
 "gp" 'magit-browse-pull-request
 "gs" 'magit-status
 "h" nil
 "i" '+format/buffer
 "j" 'multi-line-single-line
 "J" 'multi-line
 "l" 'avy-goto-line
 "k" '+default/yank-pop
 "m" 'avy-goto-line
 "n" nil
 "o" 'writeroom-mode
 "p" 'switch-to-previous-buffer
 "q" nil
 "r" 'anzu-query-replace
 "s" '+default/search-project
 "t" '+lookup/definition
 "v" 'ace-link
 "w" 'save-buffer
 "x" nil
 "y" nil
 "yc" 'aya-create
 "ye" 'aya-expand
 "yn" 'yas-new-snippet
 "yo" 'aya-create-one-line
 ;; TODO zstd erring with this package
 ;; "z" 'undo-tree-visualize
 "{" nil
 "}" nil
 ;; "n p" 'visit todo for project
 ;; "n t" 'visit todo
 )

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

(defun rk/copilot-tab ()
  "Tab command that will complet with copilot if a completion is
available. Otherwise will try company, yasnippet or normal
tab-indent."
  (interactive)
  (or (copilot-accept-completion)
      (company-yasnippet-or-completion)
      (indent-for-tab-command)))

(define-key global-map (kbd "<tab>") #'rk/copilot-tab)

(general-define-key
 :keymaps '(insert company-active-map override)
 ;; "DEL" 'hungry-delete-backward
 "M-e" 'emmet-expand-line
 "C-e" 'yas-expand
 "TAB" 'rk/copilot-tab
 "<tab>" 'rk/copilot-tab
 )

(general-define-key
 :keymaps '(Info-mode-map)
 "m" 'Info-menu
 "n" 'Info-scroll-up
 "p" 'Info-scroll-down
 )

(general-define-key
 :keymaps '(vertico-map)
 "C-o" 'embark-collect
 "RET" 'vertico-directory-enter
 )

(general-define-key
 :keymaps '(embark-collect-mode-map)
 )

(general-define-key
 :keymaps 'help-map
 "y" 'yas-describe-tables
 )

(general-define-key
 :states '(normal visual)
 :keymaps '(magit-status-mode-map)
 "s" 'magit-stage)

(evil-define-minor-mode-key 'normal 'org-src-mode
  (kbd "C-c r") 'nil
  (kbd "C-c e") 'nil
  (kbd "SPC w") 'nil
  )

(map! "C-c g" 'magit-status)
(map! "M-g" 'magit-status)
(map! "M-w" 'ace-window)
(map! :map magit-mode-map
      :n "y u" 'forge-copy-url-at-point-as-kill
      ;; TODO not overriding the 'override map
      :n "RET" 'magit-visit-thing
      )

(map! :map php-mode-map
      :n "M-t t" 'phpunit-current-test
      :n "M-t c" 'phpunit-current-class
      :n "M-t p" 'phpunit-current-project
      :n "M-t M-t" 'phpunit-current-test
      :n "M-t M-c" 'phpunit-current-class
      :n "M-t M-p" 'phpunit-current-project)

(setq phpunit-default-program "./vendor/bin/pest")
;; (setq-local phpunit-arg '("exec" "-it" "container" "phpunit")
;; or (setq-local phpunit-arg "exec -it container phpunit")

(general-define-key
 :keymaps '(override)
 "C-c p" 'projectile-command-map)

(use-package! copilot
  :hook (prog-mode . copilot-mode))
