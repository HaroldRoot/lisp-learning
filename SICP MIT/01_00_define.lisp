;;;; 改编自计算机程序的构造和解释（SICP）MIT公开课第一课中的示例代码

(DEFCONSTANT A (* 5 5))

(format t "~a ~%" A)
;;; 25

(format t "~a ~%" (* A A))
;;; 625

;;; ----------------------------

(defconstant b (+ a (* 5 a)))

(format t "~a ~%" b)
;;; 150

(format t "~a ~%" (+ a (/ b 5)))
;;; 55