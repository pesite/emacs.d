;;; -*- lexical-binding: t -*-
(unless (fboundp 'cl-flet)
  (require 'cl-lib))

(defun sanityinc/time-subtract-millis (b a)
  (* 1000.0 (float-time (time-subtract b a))))

(defvar sanityinc/require-times nil
  "A list of (FEATURE . LOAD-DURATION).
LOAD-DURATION is the time taken in milliseconds to load FEATURE.")

(defadvice require
    (around build-require-times (feature &optional filename noerror) activate)
  "Note in `sanityinc/require-times' the time taken to require each feature."
  (let* ((already-loaded (memq feature features))
         (require-start-time (and (not already-loaded) (current-time))))
    (prog1
        ad-do-it
      (when (and (not already-loaded) (memq feature features))
        (add-to-list 'sanityinc/require-times
                     (cons feature
                           (sanityinc/time-subtract-millis (current-time)
                                                           require-start-time))
                     t)))))

(defun performance/create-session-id ()
  "Create a random session id tagged with date."
  (format "%s%08x" (format-time-string "%Y%m%d" (current-time)) (random (expt 16 8))))
(defvar performance/session-id (performance/create-session-id))
(defvar performance/save-history-directory nil)

(defvar performance/log-file nil)
(defun performance/push-event (name data)
  "Push an event name with the data list data to the performance log."
  (if performance/log-file
      (let ((cur-time (current-time)))
        (write-region (concat (format-time-string "%Y-%m-%d %H:%M:%S.%3N" cur-time) "," name "," (format "%s" data) "\n") nil performance/log-file 'append))))

(let ((start-time (float-time (current-time))))
  (cl-flet ((performance/session-float-length (cur-time)
                                              (- (float-time cur-time) start-time)))

    (add-hook 'kill-emacs-hook
              #'(lambda ()
                  (unless noninteractive
                    (let ((run-time (get-internal-run-time))
                          (cur-time (current-time)))
                      (let ((session-length (performance/session-float-length cur-time)))

                        (if performance/save-history-directory
                            (progn
                              (performance/push-event "SESSION-END" (concat (format-time-string "%S s; %3N ms" run-time) " Average load: " (format "%.3f" (/ (float-time run-time) session-length)) " over " (format "%.3f s" session-length) "; " performance/session-id))
                              (if (> 0 (length command-history)) (write-region (command-history) nil (expand-file-name performance/session-id performance/save-history-directory))))
                          (performance/push-event "SESSION-END" (concat (format-time-string "%S s; %3N ms" run-time) " Average load: " (format "%.3f" (/ (float-time run-time) session-length)) " over " (format "%.3f s" session-length)))))))))))

(unless noninteractive
  (performance/push-event "SESSION-START"
                          (if performance/save-history-directory
                              (format "%s; %s" (format-time-string "%S s; %3N ms" (get-internal-run-time)) performance/session-id)
                            (format-time-string "%S s; %3N ms" (get-internal-run-time)))))


(add-hook 'after-init-hook
          #'(lambda ()
              (let ((time-diff (sanityinc/time-subtract-millis after-init-time before-init-time)))
                (message "init completed in %.2fms" time-diff)
                (performance/push-event "INIT-TIME" (format "%.2fms" time-diff)))))

(provide 'init-benchmarking)
