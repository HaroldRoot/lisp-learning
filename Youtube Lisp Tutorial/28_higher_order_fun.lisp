(setq *print-case* :capitalize)

;;;; Higher Order Functions

#|
在Lisp以及许多其他函数式编程语言中，
Higher-Order Functions（高阶函数）
是指那些能够接受其他函数作为参数，
或者将函数作为返回值的函数。

高阶函数是函数式编程的一个核心概念，
它们允许你将函数视为一等公民，
以便更灵活地处理和操作函数。

具体来说，高阶函数具有以下特性：

1.接受函数作为参数：
高阶函数可以接受其他函数作为参数，
这使得你可以将某个操作作为参数传递给函数，
从而在函数内部执行这个操作。
这通常用于实现通用的操作，
例如映射、过滤和折叠。

2.返回函数作为结果：
高阶函数也可以将函数作为其返回值，
这意味着函数可以动态生成其他函数。
这使得你可以在运行时根据需要创建函数。

高阶函数在函数式编程中非常有用，
它们促进了代码的模块化和可复用性，
使代码更具表达性和通用性。
一些常见的高阶函数包括 map、filter、
reduce、apply 等，它们可以用于
处理数据集合、操作函数、生成函数等等。
 |#

(defun times-3 (x) (* x 3))
(defun times-4 (x) (* x 4))

(defun multiples (mult-func max-num)
    (dotimes (x max-num)
        (format t "~d : ~d ~%" x (funcall mult-func x))))

(multiples #'times-3 3)
(multiples #'times-4 3)
#|
0 : 0 
1 : 3 
2 : 6 
0 : 0 
1 : 4 
2 : 8
 |#