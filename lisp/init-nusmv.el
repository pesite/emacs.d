(when (file-exists-p "nusmv-mode.el")
  ;; add nusmv mode
  (autoload 'nusmv-mode "nusmv-mode" "Major mode for NuSMV specification files." t)
  (setq auto-mode-alist
        (append (list '("\\.smv$" . nusmv-mode))
                auto-mode-alist))

  (autoload 'nusmv-m4-mode "nusmv-mode" " `nusmv-mode' with m4 support." t)
  (setq auto-mode-alist
        (append  (list '("\\.m4.smv$" . nusmv-m4-mode))
                 auto-mode-alist)))

(provide 'init-nusmv)
