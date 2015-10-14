;; add promela mode
(if (require 'promela-mode)
    (progn
      (autoload 'promela-mode "promela-mode" "PROMELA mode" nil t)
      (setq auto-mode-alist
            (append
             (list (cons "\\.promela$"  'promela-mode)
                   (cons "\\.spin$"     'promela-mode)
                   (cons "\\.pml$"      'promela-mode)
                   ;; (cons "\\.other-extensions$"     'promela-mode)
                   )
             auto-mode-alist)))
  (message "You might install promela-mode: See http://spinroot.com/spin/Src/promela-mode.el"))

(provide 'init-promela)
