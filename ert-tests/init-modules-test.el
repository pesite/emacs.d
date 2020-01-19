;;; init-modules --- emacs selftest
;;;
;;; Test for modules integration
;;;
;;; Commentary:

;;; Code:
;;; noninteractive

;;; Those are smoke tests, in a way, because package.el should handle everything properly

(ert-deftest has-module-ido nil
  "Emacs should have loaded ido."
  (should (featurep 'init-ido)))

(ert-deftest has-module-multiple-cursors nil
  "Emacs should have loaded multiple-cursors."
  (should (featurep 'init-multiple-cursors)))

(ert-deftest has-module-flycheck nil
  "Emacs should have loaded flycheck."
  (should (featurep 'init-flycheck)))

(ert-deftest has-module-yasnippet nil
  "Emacs should have loaded yasnippet."
  (should (featurep 'init-yasnippet)))

(ert-deftest has-module-company nil
  "Emacs should have loaded company."
  (should (featurep 'init-company)))

(ert-deftest has-module-python nil
  "Emacs should have loaded python."
  (should (featurep 'init-python)))

(ert-deftest has-module-auto-commit-mode nil
  "Emacs should have loaded auto-commit-mode."
  (should (featurep 'init-auto-commit-mode)))

(ert-deftest has-module-avy nil
  "Emacs should have loaded avy."
  (should (featurep 'init-avy)))

(ert-deftest has-module-ace-jump-buffer nil
  "Emacs should have loaded ace-jump-buffer."
  (should (featurep 'init-ace-jump-buffer)))

(ert-deftest has-module-magit nil
  "Emacs should have loaded magit."
  (should (featurep 'init-magit)))

(ert-deftest has-module-yaml-mode nil
  "Emacs should have loaded yaml-mode."
  (should (featurep 'init-yaml-mode)))

(ert-deftest has-module-counsel-etags nil
  "Emacs should have loaded counsel-etags."
  (should (featurep 'init-counsel-etags)))

(ert-deftest has-module-vlf nil
  "Emacs should have loaded vlf."
  (should (featurep 'init-vlf)))

(ert-deftest has-module-slime nil
  "Emacs should have loaded slime."
  (should (featurep 'init-slime)))

(ert-deftest has-module-restclient nil
  "Emacs should have loaded restclient."
  (should (featurep 'init-restclient)))

(ert-deftest has-module-lsp nil
  "Emacs should have loaded lsp."
  (should (featurep 'init-lsp)))

(ert-deftest has-module-cmake nil
  "Emacs should have loaded cmake."
  (should (featurep 'init-cmake)))

(ert-deftest has-module-unicode nil
  "Emacs should have loaded unicode."
  (should (featurep 'init-unicode)))

(ert-deftest has-module-misc nil
  "Emacs should have loaded misc."
  (should (featurep 'init-misc)))

;;
;; Emacs
;;
;; Local Variables:
;; indent-tabs-mode: nil
;; coding: utf-8
;; End:
;;

;;; init-modules-ets.el ends here
