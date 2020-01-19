;;; package -- python init
;;; Commentary:
;;; Code:

;; install and configure autopep8
(use-package py-autopep8
  :ensure t
  :after python
  :hook (python-mode . py-autopep8-enable-on-save))

(provide 'init-python)
