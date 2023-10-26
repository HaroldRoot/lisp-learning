(setq *print-case* :capitalize)

(defun difference (num1 num2)
    (return-from difference (- num1 num2)))

(format t "6 - 7 = ~a ~%" (difference 6 7))
;;; 6 - 7 = -1

(defun add-then-multiply (a b c)
    (setq a (+ a b))
    (setq a (* a c))
    (return-from add-then-multiply a))

(format t "(1 + 2) * 3 = ~a ~%" (add-then-multiply 1 2 3))
;;; (1 + 2) * 3 = 9