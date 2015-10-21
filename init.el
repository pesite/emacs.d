;;; init.el --- user init file      -*- no-byte-compile: t -*-
;; add .emacs.d/lisp to load-path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "base" user-emacs-directory))

(require 'init-benchmarking) ;; Measure startup time

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'init-utils)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-auto-compile)
(require 'init-exec-path) ;; Set up $PATH

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
(require 'init-auto-complete)
(require 'init-helm)
;;(require 'init-helm-thierry)
(require 'init-multi-web)
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
(require 'init-paredit)
(require 'init-rust)
(require 'init-speedbar)
(require 'init-semantic)
(require 'init-flycheck)

(provide 'init)

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
