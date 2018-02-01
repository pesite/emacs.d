;;; package -- provide js2 mode for javascript.
;;; Commentary:

;;; Code:
(require-and-load-package 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(provide 'init-js)
;;; init-js.el ends here
