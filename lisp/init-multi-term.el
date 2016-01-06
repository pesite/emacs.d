(require-package 'multi-term)

;; Disable yasnippet, so we can tab-complete
;; Enable term-line-mode binding
(add-hook 'term-mode-hook (lambda()
                            (yas-minor-mode -1)
                            (add-to-list 'term-bind-key-alist '("C-c C-j" . term-line-mode))
                            (cua-mode 1)))

(provide 'init-multi-term)
