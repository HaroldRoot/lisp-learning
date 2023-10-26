(setq *print-case* :capitalize)

(defun hello()
    (print "Hello")
    (terpri))

(hello)
;;; "Hello"

(defun get-avg (num-1 num-2)
    (/ (+ num-1 num-2) 2))

(format t "Avg 10 & 50 = ~a ~%" (get-avg 10 50))
;;; Avg 10 & 50 = 30 

(defun print-list (w x &optional y z)
    (format t "List = ~a ~%" (list w x y z)))

(print-list 1 2 3)
;;; List = (1 2 3 Nil)
;;; 由于y和z是可选参数，所以y和z可以不传，默认是Nil

(defvar *total* 0)

(defun sum (&rest nums) ; use &rest to receive multiple values
    (dolist (num nums)
        (setf *total* (+ *total* num)))
    (format t "Sum = ~a ~%" *total*))

(sum 1 2 3 4 5 6 7)
;;; Sum = 28

(defun print-list(&optional &key x y z)
    (format t "List: ~a ~%" (list x y z)))
#|
它接受三个关键字参数：x, y, z
关键字参数是一种可以通过指定参数名和值来传递的参数，
它们不需要按照固定的顺序来传递，而且可以省略不需要的参数。
 |#

(print-list :x 1 :y 2)
;;; List: (1 2 Nil) 