;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(add-hook! org-mode
           :config
           (setq evil-auto-indent nil))

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

(setq json-reformat:indent-width 2)

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
;; doom-variable-pitch-font (font-spec :family "sans" :size 20))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-spacegrey)

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

(y/auto-update-theme)

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

;; Will only work on macos/linux
;; (after! counsel
;;   (setq counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s || true"))

(use-package! evil-matchit
  :defer
  :config
  ;; use enter on folder to go into folder
  (global-evil-matchit-mode 1))

(use-package! ivy
  :defer
  :config
  ;; use enter on folder to go into folder
  (define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done))
;;
(use-package! company
  :defer
  :config
  ;; (setq company-dabbrev-downcase nil)
  ;; (setq company-dabbrev-ignore-prefix nil)
  (setq company-idle-delay 0)
  ;; (setq company-minimum-prefix-length 2)
  ;; :init
  ;; (add-hook 'after-init-hook 'global-company-mode)
  )

;; (with-eval-after-load 'company
;;   (define-key company-active-map (kbd "C-f") #'company-complete-common)
;;   (define-key company-active-map (kbd "TAB") #'company-complete-common)
;;   (define-key company-active-map (kbd "C-u") #'company-previous-page)
;;   (define-key company-active-map (kbd "C-d") #'company-next-page)
;;   (define-key company-active-map (kbd "C-n") #'company-select-next)
;;   (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; (use-package! ejira
;; :defer
;;   :init
;;   (setq jiralib2-url              (getenv "JIRA_URL")
;;         jiralib2-auth             'basic
;;         jiralib2-user-login-name  (getenv "JIRA_USER")
;;         jiralib2-token            (getenv "JIRA_TOKEN")

;;         ejira-org-directory       "~/jira"
;;         ejira-projects            '("Portal (Global)")

;;         ejira-priorities-alist    '(("Highest" . ?A)
;;                                     ("High"    . ?B)
;;                                     ("Medium"  . ?C)
;;                                     ("Low"     . ?D)
;;                                     ("Lowest"  . ?E))
;;         ejira-todo-states-alist   '(("To Do"       . 1)
;;                                     ("In Progress" . 2)
;;                                     ("Done"        . 3)))
;;   :config
;;   ;; Tries to auto-set custom fields by looking into /editmeta
;;   ;; of an issue and an epic.
;;   (add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)

;;   ;; They can also be set manually if autoconfigure is not used.
;;   ;; (setq ejira-sprint-field       'customfield_10001
;;   ;;       ejira-epic-field         'customfield_10002
;;   ;;       ejira-epic-summary-field 'customfield_10004)

;;   (require 'ejira-agenda)

;;   ;; Make the issues visisble in your agenda by adding `ejira-org-directory'
;;   ;; into your `org-agenda-files'.
;;   (add-to-list 'org-agenda-files ejira-org-directory)

;;   ;; Add an agenda view to browse the issues that
;;   (org-add-agenda-custom-command
;;    '("j" "My JIRA issues"
;;      ((ejira-jql "resolution = unresolved and assignee = currentUser()"
;;                  ((org-agenda-overriding-header "Assigned to me")))))))

;; (use-package! org-jira
;; :defer
;;   :config
;;   (setq jiralib-url "https://gfm-it.atlassian.net")
;;   )

;; (use-package! lsp-mode
;; :defer
;;   :commands lsp
;;   )

;; (use-package! company-lsp
;; :defer
;; :config
;; (push 'company-lsp company-backends)
;; )

(use-package! js2-mode
  :defer
  :config
  (setq js2-basic-offset 4)
  )

(use-package! ace-link
  :defer
  :config
  (ace-link-setup-default)
  )

(use-package! undo-tree
  :defer
  :config
  (global-undo-tree-mode 1)
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

;; (use-package! php-mode
;;   :defer
;;   :config
;;   (setq php-mode-lineup-cascaded-calls nil)
;;   )

;; (after! js2-mode
;;   (set-company-backend! 'js2-mode 'company-tide 'company-yasnippet))

;; (after! php-mode
;;   (set-company-backend! 'php-mode 'company-phpactor 'company-dabbrev-code 'company-capf 'company-files))

;; (add-hook 'php-mode-hook
;;           '(lambda ()
;;              ;; Enable company-mode
;;              (company-mode t)
;;              (require 'company-php)

;;              ;; Enable ElDoc support (optional)
;;              (ac-php-core-eldoc-setup)

;;              (set (make-local-variable 'company-backends)
;;                   '((company-ac-php-backend company-dabbrev-code)
;;                     company-capf company-files))
;;              ))

(use-package! phpunit
  :defer
  :config
  (setq phpunit-stop-on-error t)
  (setq phpunit-stop-on-failure t))

;; (use-package! dotenv-mode
;; :defer
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . dotenv-mode))
;;   )

(use-package! web-mode
  :defer
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
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

;; (defun my-open-calendar ()
;;   (interactive)
;;   (cfw:open-calendar-buffer
;;    :contents-sources
;;    (list
;;     (cfw:org-create-source "Green")  ; org-agenda source
;;     ;; (cfw:org-create-file-source "cal" "/path/to/cal.org" "Cyan")  ; other org source
;;     ;; (cfw:howm-create-source "Blue")  ; howm source
;;     ;; (cfw:cal-create-source "Orange") ; diary source
;;     ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
;;     (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
;;     )))

;; Keybinds
;;TODO use doom's map! instead of using general directly
;;
;;

(general-override-mode)

(general-define-key
 :keymaps '(ivy-occur-mode-map)
 "RET" 'ivy-occur-press-and-switch
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

(defun evil-nohl ()
  (interactive)
  (evil-ex-nohighlight))

(general-define-key
 :keymaps 'insert
 ;; "DEL" 'hungry-delete-backward
 "M-e" 'emmet-expand-line
 "C-e" 'yas-expand
 "TAB" '+company/complete
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
 "%" 'evilmi-jump-items
 ;; "&" 'er/expand-region
 "s" 'avy-goto-word-1
 "S" 'avy-goto-char)

(general-define-key
 :states '(normal visual)
 :keymaps '(override)
 "SPC" nil
 )

(setq my-leader1 "SPC")
(
 general-define-key
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
 "." 'ivy-resume
 "/" nil
 ";" nil
 "=" nil
 "@" nil
 "F" 'counsel-file-jump
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
 "j" 'multi-line-single-line
 "J" 'multi-line
 "k" 'counsel-yank-pop
 "l" 'avy-goto-line
 "m" 'avy-goto-line
 "n" nil
 "o" 'writeroom-mode
 "p" 'switch-to-previous-buffer
 "q" nil
 "r" 'anzu-query-replace
 "s" 'counsel-rg
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

;; (general-define-key
;;  :keymaps 'company-active-map
;;  :states 'normal
;;  "SPC" 'ignore)

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

(general-define-key
 :keymaps '(override)
 "C-c p" 'projectile-command-map)
