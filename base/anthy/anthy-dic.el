;; anthy-dic.el -- Anthy

;; Copyright (C) 2001 - 2005
;; Author: Yusuke Tabata<yusuke@w5.dion.ne.jp>
;;       : Tomoharu Ugawa

;; This file is part of Anthy

;;; Commentary:
;;
;; tooo experimental
;;
;;
;; Funded by IPA$BL$F'%=%U%H%&%'%"AOB$;v6H(B 2001 11/10

;;; Code
(defvar anthy-dic-util-command "anthy-dic-tool")
(defvar anthy-dic-buffer-name " *anthy-dic*")

(defun anthy-add-word-compose-paramlist (param)
  (let ((str ""))
    (while param
      (let* ((cur (car param))
	     (var (car cur))
	     (val (if (stringp (car (cdr cur)))
		      (car (cdr cur))
		    (if (car (cdr cur)) "y" "n"))))
	(setq str (concat str
			  var "\t=\t" val "\n")))
      (setq param (cdr param)))
    str))

(defun anthy-add-word (yomi freq word paramlist)
  (let ((proc))
    (setq proc (start-process "anthy-dic" anthy-dic-buffer-name
			      anthy-dic-util-command "--append"))
    (if proc
	(progn
	  (if anthy-xemacs
	      (if (coding-system-p (find-coding-system 'euc-japan))
		  (set-process-coding-system proc 'euc-japan 'euc-japan))
	    (cond ((coding-system-p 'euc-japan)
		   (set-process-coding-system proc 'euc-japan 'euc-japan))
		  ((coding-system-p '*euc-japan*)
		   (set-process-coding-system proc '*euc-japan* '*euc-japan*))))
	  (process-send-string proc
			       (concat yomi " " (int-to-string freq) " " word "\n"))
	  (process-send-string proc
			       (anthy-add-word-compose-paramlist paramlist))
	  (process-send-string proc "\n")
	  (process-send-eof proc)
	  t)
      nil)))

(defun anthy-dic-get-noun-category (word)
  (let
      ((res '(("$BIJ;l(B" "$BL>;l(B")))
       (na (y-or-n-p (concat "$B!V(B" word "$B$J!W$H8@$$$^$9$+(B? ")))
       (sa (y-or-n-p (concat "$B!V(B" word "$B$5!W$H8@$$$^$9$+(B? ")))
       (suru (y-or-n-p (concat "$B!V(B" word "$B$9$k!W$H8@$$$^$9$+(B? ")))
       (ind (y-or-n-p (concat "$B!V(B" word "$B!W$OC1FH$GJ8@a$K$J$j$^$9$+(B? ")))
       (kaku (y-or-n-p (concat "$B!V(B" word "$B$H!W$H8@$$$^$9$+(B? "))))
    (setq res (cons `("$B$J@\B3(B" ,na) res))
    (setq res (cons `("$B$5@\B3(B" ,sa) res))
    (setq res (cons `("$B$9$k@\B3(B" ,suru) res))
    (setq res (cons `("$B8l44$N$_$GJ8@a(B" ,ind) res))
    (setq res (cons `("$B3J=u;l@\B3(B" ,kaku) res))
    res))

(defun anthy-dic-get-special-noun-category (word)
  (let 
      ((res '())
       (cat (string-to-int
	     (read-from-minibuffer "1:$B?ML>(B 2:$BCOL>(B: "))))
    (cond ((= cat 1)
	   (setq res '(("$BIJ;l(B" "$B?ML>(B"))))
	  ((= cat 2)
	   (setq res '(("$BIJ;l(B" "$BCOL>(B")))))
    res))

(defun anthy-dic-get-adjective-category (word)
  '(("$BIJ;l(B" "$B7AMF;l(B")))

(defun anthy-dic-get-av-category (word)
  (let
      ((res '(("$BIJ;l(B" "$BI{;l(B")))
       (to (y-or-n-p (concat "$B!V(B" word "$B$H!W$H8@$$$^$9$+(B?")))
       (taru (y-or-n-p (concat "$B!V(B" word "$B$?$k!W$H8@$$$^$9$+(B?")))
       (suru (y-or-n-p (concat "$B!V(B" word "$B$9$k!W$H8@$$$^$9$+(B?")))
       (ind (y-or-n-p (concat "$B!V(B" word "$B!W$OC1FH$GJ8@a$K$J$j$^$9$+(B?"))))
    (setq res (cons `("$B$H@\B3(B" ,to) res))
    (setq res (cons `("$B$?$k@\B3(B" ,taru) res))
    (setq res (cons `("$B$9$k@\B3(B" ,suru) res))
    (setq res (cons `("$B8l44$N$_$GJ8@a(B" ,ind) res))
    res))

;; taken from tooltip.el
(defmacro anthy-region-active-p ()
  "Value is non-nil if the region is currently active."
  (if (string-match "^GNU" (emacs-version))
      `(and transient-mark-mode mark-active)
    `(region-active-p)))

(defun anthy-add-word-interactive ()
  ""
  (interactive)
  (let
      ((param '()) (res '())
       (word (if (anthy-region-active-p)
		 (buffer-substring (region-beginning) (region-end))
	       ""))
       yomi cat)
    (and (string= word "")
	 (setq word (read-from-minibuffer "$BC18l(B($B8l44$N$_(B): ")))
    (setq yomi (read-from-minibuffer (concat "$BFI$_(B (" word "): ")))
    (setq cat (string-to-int
	       (read-from-minibuffer
		"$B%+%F%4%j!<(B 1:$B0lHLL>;l(B 2:$B$=$NB>$NL>;l(B 3:$B7AMF;l(B 4:$BI{;l(B: ")))
    (cond ((= cat 1)
	   (setq param (anthy-dic-get-noun-category word)))
	  ((= cat 2)
	   (setq param (anthy-dic-get-special-noun-category word)))
	  ((= cat 3)
	   (setq param (anthy-dic-get-adjective-category word)))
	  ((= cat 4)
	   (setq param (anthy-dic-get-av-category word))))
    (if param
	(setq res (anthy-add-word yomi 1 word param)))
    (if res
	(message (concat word "(" yomi ")$B$rEPO?$7$^$7$?(B")))))

(provide 'anthy-dic)
