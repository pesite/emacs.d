
(use-package lsp-mode
  :ensure t
  :hook ((java-mode . lsp)
	 (python-mode . lsp))
  :commands (lsp lsp-deferred lsp-ui-mode))

(use-package lsp-java :ensure t)
;; Note: You can change the path of the ccls executable customizing ccls-executable
(use-package ccls
  :ensure t
  :hook ((c++-mode . (lambda () (set (make-local-variable 'lsp-prefer-flymake) nil)))))

;; optionally
(use-package lsp-ui :commands lsp-ui-mode :ensure t)
(use-package company-lsp
  :commands company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))
(use-package helm-lsp :commands helm-lsp-workspace-symbol :ensure t)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list :ensure t)
;; optionally if you want to use debugger
(use-package dap-mode
  :ensure t :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package dap-java :after (lsp-java))

(provide 'init-lsp)
