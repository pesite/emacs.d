;;; init-misc,el -- miscellaneous config for emacs
;;; Commentary:
;;;        There are a few configs that don't fit anywhere else
;;; Code:
;; temporary dir
(setq temporary-file-directory (expand-file-name "tmp" user-emacs-directory))

;;
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

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

;; set default splitting to vertical
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; set default font
(set-frame-font "-b&h-lucidatypewriter-medium-r-normal-sans-12-116-75-75-m-70-iso10646-1")

;; add custom commands
 ;;; cut out line
(defun custom-kill-whole-line ()
  "Kill a whole line similar to kill-whole-line.
Not as fancy, as it does not support multi line kill or better undo."
  (interactive)
  (beginning-of-line)
  (kill-line))
(global-set-key (kbd "<C-S-backspace>") 'custom-kill-whole-line)

 ;;; find and insert path
(defun find-and-insert-path ()
  "Insert the path of a file in current point.
Use `ido-find-file` to get the file, of which the path should be inserted.
  (interactive)"
  (let ((origin (current-buffer)))
    (ido-find-file)
    (let ((name (buffer-file-name)))
      (kill-buffer (current-buffer))
      (switch-to-buffer origin)
      (insert name))))

;; activate delete selection mode - to delete regions fully, when selected a backspace hit
(delete-selection-mode)

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

;; cua-mode
(cua-mode t)

;; fix clipboard clashes with other applications
(setq x-select-enable-clipboard t)
(setq x-select-enable-clipboard-manager t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

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

(provide 'init-misc)

;;; init-misc.el ends here
