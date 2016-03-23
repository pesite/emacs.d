;;; package -- provide js3 mode for javascript.
;;; Commentary:

;;; Code:
(require-and-load-package 'js3-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

(provide 'init-js)
;;; init-js.el ends here
