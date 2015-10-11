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

;; auto multi-web-mode
(setq auto-mode-alist
      (append
       (list (cons "\\.php$"  'multi-web-mode)
	     ;; (cons "\\.other-extensions$"     'promela-mode)
	     )
       auto-mode-alist))

;; add promela mode
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

;; add nusmv mode
(autoload 'nusmv-mode "nusmv-mode" "Major mode for NuSMV specification files." t)
(setq auto-mode-alist
      (append (list '("\\.smv$" . nusmv-mode))
              auto-mode-alist))

(autoload 'nusmv-m4-mode "nusmv-mode" " `nusmv-mode' with m4 support." t)
(setq auto-mode-alist
      (append  (list '("\\.m4.smv$" . nusmv-m4-mode))
               auto-mode-alist))

;; add slime
(add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup '(slime-fancy)) ; almost everything

;; add some mode bindings
(setq auto-mode-alist (cons '("\\.octave$" . octave-mode) auto-mode-alist))

;; scala - mode
(add-to-list 'load-path "~/.emacs.d/scala-mode/")
(require 'scala-mode-auto)

;; add jslint for javascript validation
(require 'flymake-jslint)
(add-hook 'javascript-mode-hook
          (lambda () (flymake-mode 1)))

;; flymake cursor and other settings
(require 'flymake-cursor)
(defun flymake-get-tex-args (file-name)
  (list "latex" (list "-file-line-error-style" "-interaction=nonstopmode" file-name)))

;; replace js-mode by js2-mode for proper indentation
(autoload 'js2-mode "js2-mode" nil t)
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Configure flymake for Python
(setq pylint "/usr/bin/epylint")
;; (when (load "flymake" t)
;;   (defun flymake-pylint-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list (expand-file-name pylint "") (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pylint-init)))

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

;; flymake for html
(defun flymake-html-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "tidy" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.html$\\|\\.ctp" flymake-html-init))

(add-to-list 'flymake-err-line-patterns
	     '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
	       nil 1 2 4))

;; Flymake for LaTeX
(defun flymake-get-tex-args (file-name)
  (list "/home/patti/texlive/dist/bin/x86_64-linux/chktex" (list "-g0" "-r" "-l" (expand-file-name "~/.chktexrc") "-I" "-q" "-v0" file-name)))
(push
 '("^\\(\.+\.tex\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
   1 2 3 4) flymake-err-line-patterns)

;; cmake mode
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists.txt$" . cmake-mode))

;; ParEdit
(require 'paredit)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

;; rust mode
(add-to-list 'load-path "~/.emacs.d/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; window speedbar
(require 'sr-speedbar)

;; auto-completion
(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)
(setq-default ac-sources '(ac-source-semantic-raw))

;; config multi-web-mode
(with-eval-after-load 'multi-web-mode
  (setq mweb-default-major-mode 'html-mode)
  (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                    (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                    (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
  (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
  (multi-web-global-mode 1))

;; add gccsense
(require 'gccsense)
(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key (kbd "<C-tab>") 'ac-complete-gccsense)))

;; tags
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command 
   (format "find %s -type f -name \"*.[ch]\" | etags -" dir-name)))

  ;;;  Jonas.Jarnestrom<at>ki.ericsson.se A smarter               
  ;;;  find-tag that automagically reruns etags when it cant find a               
  ;;;  requested item and then makes a new try to locate it.                      
  ;;;  Fri Mar 15 09:52:14 2002
(defadvice find-tag (around refresh-etags activate)
  "Rerun etags and reload tags if tag not found and redo find-tag.              
   If buffer is modified, ask about save before running etags."
  (let ((extension (file-name-extension (buffer-file-name))))
    (condition-case err
        ad-do-it
      (error (and (buffer-modified-p)
                  (not (ding))
                  (y-or-n-p "Buffer is modified, save it? ")
                  (save-buffer))
             (er-refresh-etags extension)
             ad-do-it))))
(defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently."
  (interactive)
  (shell-command (format "etags *.%s" (or extension "el")))
  (let ((tags-revert-without-query t))  ; don't query, revert silently          
    (visit-tags-table default-directory nil)))

;;; semantic auto-completion -- http://emacswiki.org/emacs/AutoCompleteSources#toc6
(defun ac-semantic-construct-candidates (tags)
  "Construct candidates from the list inside of tags."
  (apply 'append
         (mapcar (lambda (tag)
                   (if (listp tag)
                       (let ((type (semantic-tag-type tag))
                             (class (semantic-tag-class tag))
                             (name (semantic-tag-name tag)))
                         (if (or (and (stringp type)
                                      (string= type "class"))
                                 (eq class 'function)
                                 (eq class 'variable))
                             (list (list name type class))))))
                 tags)))


(defvar ac-source-semantic-analysis nil)
(setq ac-source-semantic
      `((sigil . "b")
        (init . (lambda () (setq ac-source-semantic-analysis
                                 (condition-case nil
                                     (ac-semantic-construct-candidates (semantic-fetch-tags))))))
        (candidates . (lambda ()
                        (if ac-source-semantic-analysis
                            (all-completions ac-target (mapcar 'car ac-source-semantic-analysis)))))))
