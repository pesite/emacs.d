;; elpa config
(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
(setq
 package-archives '(("org" . "http://orgmode.org/elpa/")
		    ("melpa" . "https://melpa.org/packages/")))

(defun init-elpa/initialize-package ()
  (unless nil ;package--initialized
    ;; optimization, no need to activate all the packages so early
    (setq package-enable-at-startup nil)
    (package-initialize)))

(init-elpa/initialize-package)

;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install package `%s': %S" package err)
     nil)))

(defun require-and-load-package (package &optional min-version no-refresh)
  (require-package package min-version no-refresh)
  (require package))

(provide 'init-elpa)
;;; init-elpa.el ends here
