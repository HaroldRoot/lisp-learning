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
;;; lisp �����ø�̾�ź͵Ⱥű�ʾ != ��������

(if (or (<= *age* 14) (>= *age* 67))
    (format t "Work if you want~%")
    (format t "Time to work~%"))
;;; Time to work