(setq *PRINT-CASE* :capitalize)

(defvar *num* 0)

(setf *num* 6)

(format t "~a" *num*)

(defparameter *number* 1) ; ������˵defvar��defparameterĿǰû������

(setf *number* 7)

(format t "~a" *number*)