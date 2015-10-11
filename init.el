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

;; temporary
(setq temporary-file-directory "~/.emacs.d/tmp") 

;;
(setq-default indent-tabs-mode nil)
(add-to-list 'load-path "/home/patti/.emacs.d/lisp")
(add-to-list 'load-path "/home/patti/.emacs.d/base")

; set auto-save file handling
;; Save all tempfiles in $TMPDIR/emacs$UID/                                                  
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

; set default splitting to vertical
(setq split-height-threshold nil)
(setq split-width-threshold 0)

; set default font
(set-default-font "-b&h-lucidatypewriter-medium-r-normal-sans-12-116-75-75-m-70-iso10646-1")

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

; ido - mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode 1)

; elpa config
(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; epa enable
(epa-file-enable)

;; kill word backwards
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region) ; rebind kill region

;; remove toolbar and scrollbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; color set
(set-cursor-color "DarkOrange")
(set-background-color "black")
(set-foreground-color "white")

;; deactivate copy on setting mouse mark
(setq mouse-drag-copy-region nil)

;; enable printing
(setq lpr-page-header-switches (quote ("-o6")))

; cua-mode
(cua-mode t)

; fix clipboard clashes with other applications
(setq x-select-enable-clipboard t)
(setq x-select-enable-clipboard-manager t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;(global-set-key (kbd "C-c") 'clipboard-kill-ring-save)
;(global-set-key (kbd "C-v") 'clipboard-yank)

;; change hippie expand key
(when (load "hippie-exp" t)
  (global-set-key (kbd "<C-tab>") 'dabbrev-expand)) ; 'hippie-expand))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eclim-eclipse-dirs (quote ("~/eclipse")))
 '(eclim-executable "~/eclipse/eclim")
 '(org-support-shift-select t))

;; load editorconfig
(load "editorconfig")

;; set fundamental mode to org mode
(setq-default major-mode 'org-mode)

;; auto-complete
(if (fboundp 'ac-config-default)
    (ac-config-default)
  (message "Please install auto-complete."))
