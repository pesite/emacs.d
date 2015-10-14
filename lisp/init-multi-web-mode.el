(require-package 'multi-web-mode)

;; auto multi-web-mode
(setq auto-mode-alist
      (append
       (list (cons "\\.php$" 'multi-web-mode)
	     ;; (cons "\\.other-extensions$"     'promela-mode)
	     )
       auto-mode-alist))

(provide 'init-multi-web-mode)
