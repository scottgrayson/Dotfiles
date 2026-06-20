;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Doom workspaces disabled in init.el; hide tab bar (agent-shell-workspace uses it internally)
(setq tab-bar-show nil)

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

;; materialized-theme — used by xenodium (agent-shell creator) for readability
(setq doom-theme 'doom-material)

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
  (setq lsp-restart 'auto-restart)
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
  (setq phpunit-default-program "./vendor/bin/pest")
  (setq phpunit-args '("--colors=never"))
  ;; (setq phpunit-stop-on-error t)
  ;; (setq phpunit-stop-on-failure t)
  )

;; Localleader stays at SPC m (Doom default). Comma used for custom commands below.

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
          Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; ── Normal mode bindings ──
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
(remove-hook 'doom-first-input-hook #'evil-snipe-override-mode)
(map! :nv "s" #'avy-goto-word-1
      :nv "S" #'avy-goto-char
      :nv "(" #'diff-hl-previous-hunk
      :nv ")" #'diff-hl-next-hunk
      :nv "[" #'flycheck-previous-error
      :nv "]" #'flycheck-next-error
      :nv "#" #'evilnc-comment-or-uncomment-lines
      :nv "%" #'evilmi-jump-items
      :n  "RET" #'evil-ex-nohighlight)

;; ── Comma prefix: custom commands (normal/visual mode) ──
;; SPC is left as pure Doom defaults. Comma is the custom quick-access layer.
(define-prefix-command 'my-comma-map)
(map! :nv "," #'my-comma-map)
(map! :map my-comma-map
      "."  #'vertico-repeat
      "B"  #'switch-to-buffer
      "R"  #'anzu-query-replace-at-cursor
      "~"  #'string-inflection-all-cycle
      "b"  #'projectile-switch-to-buffer
      "c"  #'org-capture
      "d"  #'+default/find-in-notes
      "f"  #'projectile-find-file
      "i"  #'+format/buffer
      "j"  #'multi-line-single-line
      "J"  #'multi-line
      "l"  #'avy-goto-line
      "k"  #'+default/yank-pop
      "o"  #'doom/window-maximize-buffer
      "r"  #'anzu-query-replace
      "s"  #'+default/search-project
      "t"  #'+lookup/definition
      "v"  #'ace-link
      "w"  #'save-buffer
      (:prefix ("g" . "git")
       "g" #'magit-status
       "b" #'magit-blame
       "f" #'browse-at-remote
       "l" #'magit-log-buffer-file
       "s" #'magit-status)
      (:prefix ("y" . "yasnippet")
       "c" #'aya-create
       "e" #'aya-expand
       "n" #'yas-new-snippet
       "o" #'aya-create-one-line))

;; ── Agent prefix (,a) — shares keymap with C-a ──
;; my-agent-map defined in ai-config.el; wired to comma-map after load! below

;; ── Window bindings (SPC w prefix — augments Doom's +window) ──
(map! :map evil-window-map
      "q" #'evil-window-delete
      "s" #'evil-window-vsplit
      "S" #'evil-window-split
      "c" #'ace-swap-window
      "x" #'evil-window-delete
      "n" #'evil-window-next
      "u" #'winner-undo
      "r" #'winner-redo
      "a" #'balance-windows
      "o" #'delete-other-windows
      "SPC" #'ace-window)

(defun rk/copilot-tab ()
  "Tab command that will complet with copilot if a completion is
available. Otherwise will try company, yasnippet or normal
tab-indent."
  (interactive)
  (or (copilot-accept-completion)
      (company-complete)
      (indent-for-tab-command)))

(define-key global-map (kbd "<tab>") #'rk/copilot-tab)

(general-define-key
 :keymaps '(insert company-active-map override)
 ;; "DEL" 'hungry-delete-backward
 "M-e" 'emmet-expand-line
 "C-e" 'yas-expand
 "M-TAB" 'rk/copilot-tab
 "M-<tab>" 'rk/copilot-tab
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
 ", g s" 'magit-stage)

(evil-define-minor-mode-key 'normal 'org-src-mode
  (kbd "C-c r") 'nil
  (kbd "C-c e") 'nil
  (kbd "SPC w") 'nil
  )

(map! "C-c g" 'magit-status)
(map! "M-g" 'magit-status)
(map! "M-w" 'ace-window)

(map! :map magit-mode-map
      :n "y u" 'browse-at-remote-kill
      ;; TODO not overriding the 'override map
      :n "RET" 'magit-visit-thing
      :n "SPC g S" 'magit-stage
      )

(map! :map php-mode-map
      :n "M-t t" 'phpunit-current-test
      :n "M-t c" 'phpunit-current-class
      :n "M-t p" 'phpunit-current-project
      :n "M-t M-t" 'phpunit-current-test
      :n "M-t M-c" 'phpunit-current-class
      :n "M-t M-p" 'phpunit-current-project)


(general-define-key
 :keymaps '(override)
 "C-c p" 'projectile-command-map)

(use-package! copilot
  :config (setq copilot-node-executable "/Users/scottgrayson/.nvm/versions/node/v22.1.0/bin/node")
  :hook (prog-mode . copilot-mode))

;; Ensure nvm/homebrew paths are available (needed for claude-agent-acp)
(add-to-list 'exec-path (expand-file-name "~/.nvm/versions/node/v23.11.0/bin"))
(setenv "PATH" (concat (expand-file-name "~/.nvm/versions/node/v23.11.0/bin") ":" (getenv "PATH")))

;; Agent Shell — Claude Code via ACP
;; Wrap in condition-case so a missing package doesn't block ai-config loading
(condition-case err
    (progn
      (require 'acp)
      (require 'agent-shell)

      ;; Open agent-shell as a regular buffer, not a Doom popup
      (set-popup-rule! "^\\*agent-shell\\*" :ignore t)

      ;; Strip ^M (CRLF) from agent-shell output
      (add-hook 'agent-shell-mode-hook
                (lambda ()
                  (add-hook 'comint-preoutput-filter-functions
                            (lambda (output)
                              (replace-regexp-in-string "\r" "" output))
                            nil t)))

      ;; Disable text completion in agent-shell
      (add-hook 'agent-shell-mode-hook
                (lambda ()
                  (company-mode -1))))
  (error (message "⚠ agent-shell setup failed: %s" err)))

;; Agent shell ecosystem + Claude chat (managed by ai-config)
(message ">>> About to load ai-config")
(condition-case err
    (progn
      (load! "ai-config")
      ;; Wire ,a prefix to shared agent keymap (defined in ai-config.el)
      (when (boundp 'my-agent-map)
        (define-key my-comma-map (kbd "a") my-agent-map))
      (message ">>> ai-config loaded OK, my/startup-agent-workspace=%s"
               (fboundp 'my/startup-agent-workspace)))
  (error (message ">>> ai-config load FAILED: %s" err)))
