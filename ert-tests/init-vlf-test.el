;;; init-vlf-test --- emacs has vlf selftest
;;;
;;; Test for vlf integration
;;;
;;; Commentary:

;;; Code:
;;; noninteractive

(ert-deftest has-vlf nil
  "Emacs should have access to vlf"
  (should (featurep 'init-vlf))
  (should (featurep 'vlf)))

;;
;; Emacs
;;
;; Local Variables:
;; indent-tabs-mode: nil
;; coding: utf-8
;; End:
;;

;;; init-vlf-test.el ends here
