;; Test loading chain
(message "TEST: acp available? %s" (locate-library "acp"))
(message "TEST: agent-shell available? %s" (locate-library "agent-shell"))
(message "TEST: agent-shell-workspace available? %s" (locate-library "agent-shell-workspace"))
(message "TEST: ai-config.el exists? %s" (file-exists-p (expand-file-name "~/.doom.d/ai-config.el")))
(message "TEST: ai-config.el readable? %s" (file-readable-p (expand-file-name "~/.doom.d/ai-config.el")))

;; Try loading ai-config directly
(condition-case err
    (progn
      (load (expand-file-name "~/.doom.d/ai-config.el") nil t)
      (message "TEST: ai-config loaded OK"))
  (error (message "TEST: ai-config load ERROR: %s" err)))

(message "TEST: after load - my/startup-agent-workspace defined? %s" (fboundp 'my/startup-agent-workspace))
