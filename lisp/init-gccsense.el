(if (require 'gccsense nil :noerror)
    (progn
      ;; add gccsense
      (add-hook 'c-mode-common-hook
                (lambda ()
                  (local-set-key (kbd "<C-tab>") 'ac-complete-gccsense)))

      ;; tags
      (defun create-tags (dir-name)
        "Create tags file."
        (interactive "Directory: ")
        (eshell-command
         (format "find %s -type f -name \"*.[ch]\" | etags -" dir-name)))

      ;;  Jonas.Jarnestrom<at>ki.ericsson.se A smarter
      ;;  find-tag that automagically reruns etags when it cant find a
      ;;  requested item and then makes a new try to locate it.
      ;;  Fri Mar 15 09:52:14 2002
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

      ;; semantic auto-completion -- http://emacswiki.org/emacs/AutoCompleteSources#toc6
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
                                  (all-completions ac-target (mapcar 'car ac-source-semantic-analysis))))))))
  (message "gccsense not installed. Please look under http://cx4a.org/software/gccsense/manual.html on how to install."))


(provide 'init-gccsense)
