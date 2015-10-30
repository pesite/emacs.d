;; replace js-mode by js2-mode for proper indentation
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq-default js2-basic-offset 2)

(provide 'init-js)
