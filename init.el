;;; init.el  -*- no-byte-compile: t -*-
;;; Code:

;; timestamping in *Mesages* (see: https://www.reddit.com/r/emacs/comments/2094tl/how_can_i_improve_emacs_performance/)
(defun current-time-microseconds ()
  (let* ((nowtime (current-time))
         (now-ms (nth 2 nowtime)))
    (concat (format-time-string "[%Y-%m-%dT%T" nowtime) (format ".%d] " now-ms))))

(defadvice message (before test-symbol activate)
  (if (not (string-equal (ad-get-arg 0) "%s%s"))
      (let ((deactivate-mark nil)
            (inhibit-read-only t))
        (save-excursion
          (set-buffer "*Messages*")
          (goto-char (point-max))
          (if (not (bolp))
              (newline))
          (insert (current-time-microseconds))))))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; create customization group
(defgroup my/config nil
  "Local emacs config options for local lisp/init-modules.el."
  :group 'convenience)

;; testing
(defcustom my/config/debug-tracing-enabled-p nil
  "Enable debug tracing that prints a message everytime a file is loaded."
  :group 'my/config
  :type 'boolean)

(defun his-tracing-function (orig-fun &rest args)
  "Print ARGS of ORIG-FUN."
  (message "load called with args %S" args)
  (let ((res (apply orig-fun args)))
    ;;;;; (message "display-buffer returned %S" res)
    res))

;; Add to load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; set coding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; cua-mode
(cua-mode t)

;; load elpa
(require 'init-elpa)
(require 'init-exec-path)

;; install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; load modules
(use-package init-modules)

;; set customization file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p (expand-file-name "custom.el" user-emacs-directory))
    (load custom-file))

;; enable debug tracing, if set
(if my/config/debug-tracing-enabled-p
    (advice-add 'load :around #'his-tracing-function))

;; colour set
(defun set-color-theme ()
  "Set colour scheme."
  (set-cursor-color "DarkOrange")
  (set-background-color "black")
  (set-foreground-color "white")
  ;; set a default font
  (when (member "DejaVu Sans Mono" (font-family-list))
    (set-face-attribute 'default nil :font "DejaVu Sans Mono"))
  (set-frame-font "-b&h-lucidatypewriter-medium-r-normal-sans-12-116-75-75-m-70-iso10646-1"))

(set-color-theme)

;; remove toolbar and scrollbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; frame colouring on daemon mode
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (select-frame frame)
                (set-color-theme))))

;; set auto-save file handling
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist
      `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
      emacs-tmp-dir)

;; remove trailing whitespaces on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Warns when opening files bigger than 5MB.
(setq large-file-warning-threshold (* 5 1024 1024))

;; add custom commands
;;; cut out line
(defun custom-kill-whole-line ()
  "Kill a whole line similar to 'kill-whole-line'.
Not as fancy, as it does not support multi line kill or better undo."
  (interactive)
  (beginning-of-line)
  (kill-line))
(global-set-key (kbd "<C-S-backspace>") 'custom-kill-whole-line)

;; kill word backwards
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region) ; rebind kill region

;; set fundamental mode to org mode
(setq-default major-mode 'org-mode)

;; Enables nice scrolling.
(setq scroll-margin 0)
(setq scroll-conservatively 100000)
(setq scroll-preserve-screen-position 1)

;; window resizing shortcuts
(global-set-key (kbd "S-M-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-M-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-s-<down>") 'shrink-window)
(global-set-key (kbd "S-M-s-<up>") 'enlarge-window)

;; Store pastes from other programs in the kill-ring before
;; overwriting with Emacs' yanks.
(setq save-interprogram-paste-before-kill t)

;; set initial scratch
(setq initial-scratch-message "\
;;    ____
;;   / __/_ _  ___ ________
;;  / _//  ' \/ _ `/ __(_-<
;; /___/_/_/_/\_,_/\__/___/
")
