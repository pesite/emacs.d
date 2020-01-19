(require-and-load-package 'exec-path-from-shell)

(eval-after-load 'exec-path-from-shell
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "GOPATH" "GOROOT"))
    (add-to-list 'exec-path-from-shell-variables var)))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; add default shell env from ~/.shellenv
(if (file-exists-p "~/.shellenv")
    (let ((path (shell-command-to-string ". ~/.shellenv; echo -n $PATH")))
      (setenv "PATH" path)
      (setq exec-path
            (append
             (split-string-and-unquote path ":")
             exec-path))))

(provide 'init-exec-path)
