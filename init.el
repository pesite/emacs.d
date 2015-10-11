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

; tml - support ; wip
(setq auto-mode-alist (cons '("\\.tml$" . nxml-mode) auto-mode-alist))

;; auto multi-web-mode
(setq auto-mode-alist
      (append
       (list (cons "\\.php$"  'multi-web-mode)
	     ;; (cons "\\.other-extensions$"     'promela-mode)
	     )
       auto-mode-alist))

;; add promela mode
(add-to-list 'load-path "/home/patti/.emacs.d/base")
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
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
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
;; (eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

;; python IDE features
;(require 'pymacs)
;(autoload 'pymacs-apply "pymacs")
;(autoload 'pymacs-call "pymacs")
;(autoload 'pymacs-eval "pymacs" nil t)
;(autoload 'pymacs-exec "pymacs" nil t)
;(autoload 'pymacs-load "pymacs" nil t)
;(pymacs-load "ropemacs" "rope-")
;(setq ropemacs-enable-shortcuts nil) (setq ropemacs-local-prefix "C-c C-p")


;; (defmacro after (mode &rest body)
;;   `(eval-after-load ,mode
;;      '(progn ,@body)))

;; (after 'auto-complete
;;        (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
;;        (setq ac-use-menu-map t)
;;        (define-key ac-menu-map "\C-n" 'ac-next)
;;        (define-key ac-menu-map "\C-p" 'ac-previous))

;; (after 'auto-complete-config
;;        (ac-config-default)
;;        (when (file-exists-p (expand-file-name "~/.emacs.d/elisp/Pymacs"))
;;          (ac-ropemacs-initialize)
;;          (ac-ropemacs-setup)))

;; (after 'auto-complete-autoloads
;;        (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
;;        (add-hook 'python-mode-hook
;;                  (lambda ()
;;                    (require 'auto-complete-config)
;;                    (add-to-list 'ac-sources 'ac-source-ropemacs)
;;                    (auto-complete-mode))))

;; (add-hook 'python-mode-hook
;;           (lambda () (define-key python-mode-map (kbd "<C-tab>") 'rope-code-assist)))

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

;; yasnippet
;;(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20141223.303")
;; (require 'yasnippet)
;; (yas-load-directory "~/.emacs.d/snippets")
;; (yas-global-mode 1)

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

;; ParEdit
(require 'paredit)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

;; change hippie expand key
(when (load "hippie-exp" t)
  (global-set-key (kbd "<C-tab>") 'dabbrev-expand)) ; 'hippie-expand))

;; rust mode
(add-to-list 'load-path "~/.emacs.d/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; change font to dejavu
;; set font for all windows
;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10"))


;;; c++ ide
;; ggtags
;;(require 'ggtags)
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;               (ggtags-mode 1)
;; 	      (setq speedbar-show-unknown-files t))))

;;(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;;(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;;(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;;(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;;(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;;(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;;(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;; window speedbar
(require 'sr-speedbar)

;; auto-completion
;; (require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)
(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)

;;(setq company-backends 'company-c-headers)

;;;; company sample backend
;; (defun create-sample-backend ()
;;   (require 'company)
  
;;   (defconst sample-completions
;;     '("java.util.jar" "sun.util" "java.util" "java.net" "sun.launcher" "sun.reflect.misc" "sun.reflect.generics.repository" "sun.net.www.protocol.jar" "sun.security.action" "java.nio.charset" "java.io" "sun.nio" "sun.net.www" "java.util.zip" "java.lang.ref" "java.lang" "sun.misc" "sun.net.www.protocol.file" "java.util.concurrent" "sun.util.locale" "java.util.concurrent.atomic" "sun.reflect.annotation" "java.nio.charset.spi" "java.lang.invoke" "java.nio" "java.util.concurrent.locks" "sun.reflect" "java.security" "sun.security.util" "sun.nio.cs" "java.lang.reflect" "java.security.cert" "sun.nio.ch" "sun.net.util"))

;;   (defun string/reverse (str)
;;     "Reverse the str where str is a string"
;;     (apply #'string 
;; 	   (reverse 
;; 	    (string-to-list str))))
  
;;   (defun sample-fuzzy-match (prefix candidate)
;;     (cl-subsetp (string-to-list prefix)
;; 		(string-to-list candidate)))
  
;;   (defun company-sample-backend (command &optional arg &rest ignored)
;;     (interactive (list 'interactive))

;;     (case command
;;       (interactive (company-begin-backend 'company-sample-backend))
;;       (prefix (and (eq major-mode 'java-mode)
;; 		   (looking-back "import \.\*")
;; 		   (company-grab-symbol)))
;;       (candidates
;;        (let* ((rev-pref (string/reverse (second (split-string (thing-at-point 'line)))))
;; 	      (match-pos (string-match (regexp-quote ".") rev-pref)))
;; 	 (let ((short-pref (if match-pos (string/reverse (substring rev-pref match-pos)) "")))
;; 	   (mapcar (lambda (str) (substring str (length short-pref)))
;; 		   (remove-if-not
;; 		    (lambda (c) (sample-fuzzy-match (concat short-pref arg) c))
;; 		    sample-completions)))))
;;       (no-cache 't)))

;;   (add-to-list 'company-backends 'company-sample-backend))

;; (add-hook 'after-init-hook 'create-sample-backend)

;; immediate completion using tab
;;; (global-set-key (kbd "<C-tab>") 'company-complete-common)
(global-set-key (kbd "<C-tab>") 'auto-complete)
;; auto-complete mode everywhere -- http://emacswiki.org/emacs/AutoComplete
;; dirty fix for having AC everywhere
;; (define-globalized-minor-mode real-global-auto-complete-mode
;;   auto-complete-mode (lambda ()
;;                        (if (not (minibufferp (current-buffer)))
;;                          (auto-complete-mode 1))
;;                        ))
;; (add-hook 'after-init-hook (lambda () (real-global-auto-complete-mode t)))

;; company color
(require 'color)
;; (let ((bg (face-attribute 'default :background)))
;;   (custom-set-faces
;;    `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;;    `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;    `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;    `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;    `(company-tooltip-common ((t (:inherit font-lock-constant-face))))))

;;; java autocomplete
;;(add-to-list 'load-path "~/.emacs.d/ajc-java-complete/")
;;(require 'ajc-java-complete-config)
;;(add-hook 'java-mode-hook 'ajc-java-complete-mode)
;;(add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eclim-eclipse-dirs (quote ("~/eclipse")))
 '(eclim-executable "~/eclipse/eclim")
 '(org-support-shift-select t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#191919"))))
 '(company-scrollbar-fg ((t (:background "#0c0c0c"))))
 '(company-tooltip ((t (:inherit default :background "#050505"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face)))))

;; company eclim
;; (add-hook 'after-init-hook (lambda ()
;; 			     (require 'company-emacs-eclim)
;; 			     (company-emacs-eclim-setup)))



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

;; load editorconfig
(load "editorconfig")

;; set fundamental mode to org mode
(setq-default major-mode 'org-mode)


;; auto-complete
(add-to-list 'load-path "/home/patti/.emacs.d/elpa/auto-complete-20150618.1949")

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; (add-to-list 'load-path "/home/patti/.emacs.d/elpa/auto-complete-20150201.150")
;; (require 'auto-complete-config)
;; (add-hook 'after-init-hook (lambda ()
;; 			     (add-to-list 'ac-dictionary-directories "/home/patti/.emacs.d/ac-dict")
;; 			     (ac-config-default)
;;                              (add-to-list 'ac-modes 'php-mode)
;;                              (add-to-list 'ac-modes 'python-mode)
;;                              (add-to-list 'ac-modes 'js2-mode)
;; 			     (add-to-list 'ac-modes 'html-mode)
;; 			     (add-to-list 'ac-modes 'nxml-mode)
;; 			     (add-to-list 'ac-modes 'latex-mode)))

;; (add-hook 'after-init-hook (lambda ()
;;                              (require 'ac-company)
;;                              (ac-company-define-source ac-source-company-elisp company-elisp)
;;                              (add-hook 'emacs-lisp-mode-hook
;;                                        (lambda ()
;;                                          (add-to-list 'ac-sources 'ac-source-company-elisp)))))

;; (define-key ac-completing-map "\t" 'ac-complete)
;; (define-key ac-completing-map "\r" nil)


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
