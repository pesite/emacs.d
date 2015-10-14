;; change hippie expand key
(when (load "hippie-exp" t)
  (global-set-key (kbd "<C-tab>") 'hippie-expand)) ; 'hippie-expand))

(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))

(provide 'init-hippie-expand)
