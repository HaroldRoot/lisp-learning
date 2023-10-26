(setq *print-case* :capitalize)

(defvar *age* 18)
(defvar *num* 5)

(defvar *college-ready* nil)

(cond ((>= *age* 18)
            (setf *college-ready* 'yes)
            (format t "Ready for college ~%"))
      ((< *age* 18)
            (setf *college-ready* 'no)
            (format t "Not ready for college ~%"))
      (t (format t "Dont't know ~%")))