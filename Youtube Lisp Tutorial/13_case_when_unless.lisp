(setq *PRINT-CASE* :capitalize)

(defvar *age* 5)

(defun get-school (age)
    (case age
        (5 (print "Kindergarten"))
        (6 (print "First Grade"))
        (otherwise (print "Middle School"))))

(get-school *age*)
;;; "Kindergarten"

(terpri)
;;; puts in a new line

(defvar *agenow* 18)
(defvar *num* 5)

(when (= *agenow* 18)
    (setf *num* 18)
    (format t "Go to college you're ~d now ~%" *num*))
;;; when 语句只有在测试表达式为真时才执行子表达式，否则返回 nil
;;; Go to college you're 18 now 

(unless (not (= *agenow* 18))
    (setf *num* 18)
    (format t "Go to college you're ~d now ~%" *num*))
;;; unless 语句只有在测试表达式为假时才执行子表达式，否则返回 nil
;;; Go to college you're 18 now 

#|
when 语句和 unless 语句都是 if 语句的变体，它们可以用 if 语句来表示。例如：
(when test-form body-forms...) == (if test-form (progn body-forms...) nil)
(unless test-form body-forms...) == (if test-form nil (progn body-forms...))
 |#