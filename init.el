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
(setq temporary-file-directory "~/.emacs.d/tmp/") 

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

; add promela mode
(require 'promela-mode)
(autoload 'promela-mode "promela-mode" "PROMELA mode" nil t)
(setq auto-mode-alist
      (append
       (list (cons "\\.promela$"  'promela-mode)
	     (cons "\\.spin$"     'promela-mode)
	     (cons "\\.pml$"      'promela-mode)
	     ;; (cons "\\.other-extensions$"     'promela-mode)
	     )
       auto-mode-alist))

; add nusmv mode
(autoload 'nusmv-mode "nusmv-mode" "Major mode for NuSMV specification files." t)
(setq auto-mode-alist
      (append (list '("\\.smv$" . nusmv-mode))
	       auto-mode-alist))

(autoload 'nusmv-m4-mode "nusmv-mode" " `nusmv-mode' with m4 support." t)
(setq auto-mode-alist
     (append  (list '("\\.m4.smv$" . nusmv-m4-mode))
	       auto-mode-alist))

; ess mode for r and others
(require 'ess-site)

; add slime
(add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup '(slime-fancy)) ; almost everything

; add some mode bindings
(setq auto-mode-alist (cons '("\\.html$" . html-php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.phtml$" . html-php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.php$" . html-php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.octave$" . octave-mode) auto-mode-alist))
; (setq auto-mode-alist (cons '("\\.pml$" . promela-mode) auto-mode-alist))o

; ido - mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode 1)

; elpa config
;;(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
;;(add-to-list 'package-archives 
;;	     '("marmalade" .
;;	       "http://marmalade-repo.org/packages/"))
;;(package-initialize)

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

; cua-mode
(cua-mode t)

; fix clipboard clashes with other applications
(setq x-select-enable-clipboard t)
(setq x-select-enable-clipboard-manager t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;(global-set-key (kbd "C-c") 'clipboard-kill-ring-save)
;(global-set-key (kbd "C-v") 'clipboard-yank)

;; js IDE features
(add-to-list 'load-path "~/Downloads/loadedRepos/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))

; tern auto-complete
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

;; python IDE features
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-shortcuts nil) (setq ropemacs-local-prefix "C-c C-p")


(defmacro after (mode &rest body)
  `(eval-after-load ,mode
     '(progn ,@body)))

(after 'auto-complete
       (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
       (setq ac-use-menu-map t)
       (define-key ac-menu-map "\C-n" 'ac-next)
       (define-key ac-menu-map "\C-p" 'ac-previous))

(after 'auto-complete-config
       (ac-config-default)
       (when (file-exists-p (expand-file-name "~/.emacs.d/elisp/Pymacs"))
         (ac-ropemacs-initialize)
         (ac-ropemacs-setup)))

(after 'auto-complete-autoloads
       (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
       (add-hook 'python-mode-hook
                 (lambda ()
                   (require 'auto-complete-config)
                   (add-to-list 'ac-sources 'ac-source-ropemacs)
                   (auto-complete-mode))))

(add-hook 'python-mode-hook
          (lambda () (define-key python-mode-map (kbd "<C-tab>") 'rope-code-assist)))

;; Configure flymake for Python
(setq pylint "/usr/bin/epylint")
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list (expand-file-name pylint "") (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
  (require 'cl)
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
      (let ((err (car (second elem))))
        (message "%s" (flymake-ler-text err)))))))

(add-hook 'post-command-hook 'show-fly-err-at-point)

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-0.8.0")
(require 'yasnippet)
(yas-load-directory "~/.emacs.d/snippets")

;; cmake mode
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists.txt$" . cmake-mode))

;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;; Flymake for LaTeX
(defun flymake-get-tex-args (file-name)
  (list "/home/patti/texlive/dist/bin/x86_64-linux/chktex" (list "-g0" "-r" "-l" (expand-file-name "~/.chktexrc") "-I" "-q" "-v0" file-name)))
(push
 '("^\\(\.+\.tex\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

;; change hippie expand key
(when (load "hippie-exp" t)
  (global-set-key (kbd "<C-tab>") 'dabbrev-expand)) ; 'hippie-expand))

;; change font to dejavu
;; set font for all windows
;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10"))
