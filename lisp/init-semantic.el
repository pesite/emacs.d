;; auto-completion
(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)
(setq-default ac-sources '(ac-source-semantic-raw))

(provide 'init-semantic)
