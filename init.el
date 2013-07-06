; add dead keys to map
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

; add custom commands
 ; cut out line
(defun kill-whole-line ()
  (interactive)
  (beginning-of-line)
  (kill-line)) 
(global-set-key (kbd "C-S-x") 'kill-whole-line)
 ; find and insert path
(defun find-and-insert-path ()
  (interactive)
  (let ((origin (current-buffer)))
    (ido-find-file)
    (let ((name (buffer-file-name)))
      (kill-buffer (current-buffer))
      (switch-to-buffer origin)
      (insert name))))

; activate delete selection mode - to delete regions fully, when selected a backspace hit
(delete-selection-mode)

; commands for multiple cursor mode
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

; auto-complete
(add-to-list 'load-path "/home/patti/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/patti/.emacs.d/ac-dict")
(ac-config-default)
(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'nxml-mode)
(add-to-list 'ac-modes 'latex-mode)

; tml - support ; wip
(setq auto-mode-alist (cons '("\\.tml$" . nxml-mode) auto-mode-alist))

; php - mode
(add-to-list 'load-path "/home/patti/.emacs.d/base")
(require 'php-mode)
(require 'html-php)

; add slime
(add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup '(slime-fancy)) ; almost everything

; add some mode bindings
(setq auto-mode-alist (cons '("\\.html$" . html-php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.phtml$" . html-php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.php$" . html-php-mode) auto-mode-alist))

; ido - mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode 1)

; elpa config
(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
(add-to-list 'package-archives 
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(package-initialize)

; scala - mode
(add-to-list 'load-path "~/.emacs.d/scala-mode/")
(require 'scala-mode-auto)

; epa enable
(epa-file-enable)

; add jslint for javascript validation
(require 'flymake-jslint)
(add-hook 'javascript-mode-hook
          (lambda () (flymake-mode 1)))

; flymake cursor and other settings
(require 'flymake-cursor)
(defun flymake-get-tex-args (file-name)
  (list "latex" (list "-file-line-error-style" "-interaction=nonstopmode" file-name)))

; idris-mode
(add-to-list 'load-path "~/.emacs.d/idris-mode/")
;;;;;;;(require 'idris-mode)

; replace js-mode by js2-mode for proper indentation
(autoload 'js2-mode "js2-mode" nil t)
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; kill word backwards
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region) ; rebind kill region

; remove toolbar and scrollbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; color set
(set-cursor-color "DarkOrange")
(set-background-color "black")
(set-foreground-color "white")

; deactivate copy on setting mouse mark
(setq mouse-drag-copy-region nil)

; enable printing
(setq lpr-page-header-switches (quote ("-o6")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

; fix clipboard clashes with other applications
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
