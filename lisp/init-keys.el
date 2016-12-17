;; add dead keys to map
(define-key key-translation-map [dead-grave] (lookup-key key-translation-map "\C-x8`"))
(define-key key-translation-map [dead-acute] (lookup-key key-translation-map "\C-x8'"))
(define-key key-translation-map [dead-circumflex] (lookup-key key-translation-map "\C-x8^"))
(define-key key-translation-map [dead-diaeresis] (lookup-key key-translation-map "\C-x8\""))
(define-key key-translation-map [dead-tilde] (lookup-key key-translation-map "\C-x8~"))
(define-key isearch-mode-map [dead-grave] nil)
(define-key isearch-mode-map [dead-acute] nil)
(define-key isearch-mode-map [dead-circumflex] nil)
(define-key isearch-mode-map [dead-diaeresis] nil)
(define-key isearch-mode-map [dead-tilde] nil)

(global-set-key (kbd "M-i") 'imenu)

(provide 'init-keys)
