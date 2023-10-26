(setq *print-case* :capitalize)

(defun add (num1 num2)
    (let ((sum (+ num1 num2)))
        (format t "~a + ~a = ~a ~%" num1 num2 sum)))
#||
(defun add (num1 num2) ...)
这是一个函数定义，定义了一个名为 add 的函数，
该函数接受两个参数 num1 和 num2。

(let ((sum (+ num1 num2))) ...)
在函数体中，使用 let 特殊形式创建了一个局部变量 sum，
并将其初始化为 num1 和 num2 的和。
这允许我们在函数体中使用 sum 变量来存储它们的和。
||#

(add 6 7)
;;; 6 + 7 = 13

;;; 用宏来重写

(defmacro letx (var val &rest body)
    `(let ((,var ,val)) ,@body))

(defun subtract (num1 num2)
    (letx dif (- num1 num2)
        (format t "~a - ~a = ~a ~%" num1 num2 dif)))

(subtract 6 7)
;;; 6 - 7 = -1