(setq *print-case* :capitalize)

;;;; flet 是 Common Lisp 中用于创建局部函数定义的特殊形式之一。

#||
flet 允许你在特定的作用域内定义一个或多个局部函数，
这些局部函数只在该作用域内可见，不会影响全局函数的定义。

flet 的基本语法如下：

(flet ((name (parameters)
        body)
    ...)
    body)

name 是局部函数的名称。
parameters 是局部函数的参数列表。
body 是局部函数的函数体，包括函数的具体实现。
... 可以包含多个局部函数的定义。

flet 主要用于以下情况：

1.创建局部函数以在当前作用域中使用，而不污染全局命名空间。
2.允许在一个函数内定义其他辅助函数，以帮助简化代码和逻辑。

下面是一个示例，展示了如何使用flet：
||#

(defun calculate-square-and-cube (x)
    (flet (
            (square (num) (* num num))
            (cube (num) (* num num num))
            )
        (list (square x) (cube x))
    )
)

(format t "Square: ~a, Cube: ~a~%" 
    (first (calculate-square-and-cube 3)) 
    (second (calculate-square-and-cube 3))
)
;;; Square: 9, Cube: 27

;;; 下面是youtube视频里的参考代码
(flet (
    (double-it (num) (* num 2))
    (triple-it (num) (* num 3))
    )
    (format t "Double & Triple 10 = ~d ~%" 
        (triple-it (double-it 10)))
)
;;; Double & Triple 10 = 60