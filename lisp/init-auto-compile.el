(require-package 'auto-compile)
(require-package 'dash)
(require-package 'packed)

(setq load-prefer-newer t)
;;(add-to-list 'load-path "/path/to/dash")
;;(add-to-list 'load-path "/path/to/packed")
(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

(provide 'init-auto-compile)
