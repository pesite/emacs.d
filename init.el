;;; init.el --- user init file      -*- no-byte-compile: t -*-
;;; Commentary:

;;; Code:
;; add .emacs.d/lisp to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "base" user-emacs-directory))

;; set file for performance event logging
;;(setq performance/log-file (expand-file-name "performance.log" user-emacs-directory))
;;(setq performance/save-history-directory (expand-file-name "histories" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

;; Set coding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-utils)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-auto-compile)
(require 'init-exec-path) ;; Set up $PATH

(require-package 'diminish)

;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-preload-local.el"
;;----------------------------------------------------------------------------
(require 'init-preload-local nil t)

;;-----
;; Specific config
;;-----

(require 'init-misc)
(require 'init-keys)

(require 'init-multiple-cursors)
(require 'init-ido)
(require 'init-hippie-expand)
(require 'init-yasnippet)
(require 'init-auto-complete)
(require 'init-helm)
;;(require 'init-helm-thierry)
(require 'init-paredit)
(require 'init-php)
(require 'init-multi-web)
(require 'init-lisp)
(require 'init-slime)
(require 'init-gccsense)
(require 'init-promela)
(require 'init-nusmv)
(require 'init-octave)
(require 'init-scala)
(require 'init-jslint)
(require 'init-flymake)
(require 'init-js)
(require 'init-python)
(require 'init-cmake)
(require 'init-rust)
(require 'init-speedbar)
(require 'init-semantic)
(require 'init-flycheck)
(require 'init-go)
(require 'init-lua)
(require 'init-nginx)
(require 'init-json)
(require 'init-multi-term)
(require 'init-vlf)
(require 'init-ace-jump-mode)
;;(require 'init-ctags)
(require 'init-string-inflection)
(require 'init-docker)
(require 'init-gradle)
(require 'init-editorconfig)

(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
