(setq *PRINT-CASE* :capitalize)

(defvar *num* 0)

(setf *num* 6)

(format t "~a" *num*)

(defparameter *number* 1) ; 对我来说defvar和defparameter目前没有区别

(setf *number* 7)

(format t "~a" *number*)