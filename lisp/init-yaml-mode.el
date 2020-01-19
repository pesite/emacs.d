;;; package -- yaml mode init
;;; Commentary:
;;; Code:

;; install anc configure autopep8
(use-package yaml-mode
  :ensure t)

;; install and configure jedi
(use-package flycheck-yamllint
  :ensure t
  :after yaml-mode)

(provide 'init-yaml-mode)
