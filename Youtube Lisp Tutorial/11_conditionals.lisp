(setq *PRINT-CASE* :capitalize)

(defvar *age* 20)

(if (= *age* 18)
    (format t "You're 18~%")
    (format t "You aren't 18~%"))
;;; You aren't 18

(if (not (= *age* 18))
    (format t "You aren't 18~%")
    (format t "You're 18~%"))
;;; You aren't 18
;;; lisp 不能用感叹号和等号表示 != 不等于诶

(if (or (<= *age* 14) (>= *age* 67))
    (format t "Work if you want~%")
    (format t "Time to work~%"))
;;; Time to work