(setq *print-case* :capitalize)

;;;; 使用 multiple-value-bind 来接收函数的多个返回值

(defun squares (num)
    (values (expt num 2) (expt num 3)))
#|
在 squares 函数内部，使用 values 函数返回了两个值，
分别是 num 的平方（2 次幂）和 num 的立方（3 次幂），
计算方法是使用 expt 函数。
 |#

(multiple-value-bind (a b) (squares 2)
    (format t "2^2 = ~d 2^3 = ~d ~%" a b))
;;; 2^2 = 4 2^3 = 8
#|
multiple-value-bind 用于从 squares 函数中获取多个值，
并将它们绑定到变量 a 和 b 上。
squares 2 调用 squares 函数，
将参数 2 传递给它，
并获取其返回的多个值。
这些值会被分别绑定到 a 和 b 变量上。
 |#