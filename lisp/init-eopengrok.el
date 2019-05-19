;;; package -- provide interface for opengrok.
;;; Commentary: Requires clj-opengrok: https://github.com/youngker/clj-opengrok/releases
;;;             This should be in the PATH, as well as https://github.com/universal-ctags/ctags
;;;             Maybe opengrok.jar as well, see https://github.com/oracle/opengrok/wiki/How-to-setup-OpenGrok

;;; Code:
(require-and-load-package 'eopengrok)

(define-key global-map (kbd "C-c s i") 'eopengrok-create-index)
(define-key global-map (kbd "C-c s I") 'eopengrok-create-index-with-enable-projects)
(define-key global-map (kbd "C-c s d") 'eopengrok-find-definition)
(define-key global-map (kbd "C-c s f") 'eopengrok-find-file)
(define-key global-map (kbd "C-c s s") 'eopengrok-find-reference)
(define-key global-map (kbd "C-c s t") 'eopengrok-find-text)
(define-key global-map (kbd "C-c s h") 'eopengrok-find-history)
(define-key global-map (kbd "C-c s c") 'eopengrok-find-custom)
(define-key global-map (kbd "C-c s b") 'eopengrok-resume)

(provide 'init-eopengrok)
;;; init-eopengrok.el ends here
