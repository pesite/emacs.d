;;; package -- provide jdee (java development environment) tools.
;;; Commentary:

;;; Code:

;; (require 'jde-help)
;; ;; w3 fail to load local file, so skip this feature
;; (defmethod jde-jdhelper-show-url ((this jde-jdhelper) url)
;;   (let ((doc-url (jde-url-name url)))
;;     (message "Displaying %s from %s"
;;              (oref url :class)
;;              (oref (oref url :docset) :description))
;;     (jde-jdhelper-show-document this doc-url)))

(provide 'init-jdee)
;;; init-jdee.el ends here
