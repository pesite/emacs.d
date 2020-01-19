;;; package -- restclient init
;;; Commentary:
;;; Code:

(use-package restclient
  :ensure t)

(use-package company-restclient
  :ensure t
  :after restclient)

(provide 'init-restclient)
