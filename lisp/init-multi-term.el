(require-package 'multi-term)

;; Disable yasnippet, so we can tab-complete
(add-hook 'term-mode-hook (lambda()
                            (yas-minor-mode -1)))

(provide 'init-multi-term)
