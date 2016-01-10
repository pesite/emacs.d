;;; init-ace-jump-mode --- emacs selftest
;;;
;;; Test for ace jump mode integration
;;;
;;; Commentary:

;;; Code:
;;; noninteractive

(ert-deftest has-ace-jump-mode nil
  "Emacs should have access to ace-jump-mode"
  (should (featurep 'init-ace-jump-mode))
  (should (featurep 'ace-jump-mode))
  (should (fboundp 'ace-jump-mode))
  (should (eq (global-key-binding (kbd "C-c SPC")) 'ace-jump-mode)))

;;
;; Emacs
;;
;; Local Variables:
;; indent-tabs-mode: nil
;; coding: utf-8
;; End:
;;

;;; init-ace-jump-mode.el ends here
