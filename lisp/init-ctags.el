;;; package -- provide facilities for managing ctags.
;;; Commentary:

;;; Code:
(require-and-load-package 'ctags-update)
(require-and-load-package 'etags-select)
(require-and-load-package 'etags-table)

;; enable ctags autoload
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on 'ctags-auto-update-mode'." t)
(autoload 'ctags-update "ctags-update" "update TAGS using ctags" t)

(add-hook 'c-mode-common-hook  'turn-on-ctags-auto-update-mode)
(add-hook 'emacs-lisp-mode-hook  'turn-on-ctags-auto-update-mode)

(global-set-key (kbd "C-c E") 'ctags-update)
(global-set-key "\M-." 'etags-select-find-tag)

(provide 'init-ctags)
;;; init-ctags.el ends here
