(require-package 'go-mode)
(unless (require 'go-autocomplete)
  (message "Please install gocode from https://github.com/nsf/gocode"))

(unless (executable-find "golint")
  (message "You might want to install golint from https://github.com/golang/lint"))

(unless (executable-find "godef")
  (message "You might want to install godef using go get github.com/rogpeppe/godef"))

(unless (executable-find "goimports")
  (message "You might want to install goimports using go get golang.org/x/tools/cmd/goimports"))

(defun go-test-with-coverage ()
  (interactive)
  (let ((cover-file "cover.out"))
    (shell-command (concat "go test " "--coverprofile=" cover-file " ."))
    (go-coverage cover-file)))

(if (executable-find "oracle")
    (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
  (message "You might want to install go oracle using go get golang.org/x/tools/cmd/oracle"))

(defun config-go-mode-hook ()
  ;;; from: http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
  ;; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet"))
  ;; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'config-go-mode-hook)

(provide 'init-go)
