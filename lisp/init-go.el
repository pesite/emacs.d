(require-package 'go-mode)
(unless (require 'go-autocomplete)
  (message "Please install gocode from https://github.com/nsf/gocode"))

(unless (executable-find "golint")
  (message "You might want to install golint from https://github.com/golang/lint"))

(unless (executable-find "godef")
  (message "You might want to install godef from https://github.com/rogpeppe/godef"))

(defun go-test-with-coverage ()
  (interactive)
  (let ((cover-file "cover.out"))
    (shell-command (concat "go test " "--coverprofile=" cover-file " ."))
    (go-coverage cover-file)))

(provide 'init-go)
