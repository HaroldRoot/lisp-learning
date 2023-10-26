(setq *print-case* :capitalize)

;;;; labels 是 Common Lisp 中用于创建局部函数定义的另一个特殊形式。

#||
labels 类似于 flet，但具有稍微不同的作用范围。
labels 允许你在特定的作用域内定义一个或多个局部函数，
这些函数可以相互调用，也可以递归地调用自身。
与 flet 不同，labels 也可以访问作用域内的其他局部函数。

labels 的基本语法如下：

(labels ((name (parameters)
            body)
        ...)
    body)

name 是局部函数的名称。
parameters 是局部函数的参数列表。
body 是局部函数的函数体，包括函数的具体实现。
... 可以包含多个局部函数的定义。

labels 主要用于以下情况：

1.创建具有互相递归调用关系的局部函数。
2.允许在一个函数内定义其他辅助函数，以帮助简化代码和逻辑。

下面是一个示例，展示了如何使用 labels：
||#

(defun factorial (n)
    (labels (
            (fact (x acc) ; 第一个局部函数 fact
                (if (<= x 1) ; 如果 x<=1
                    acc ; 返回 account 累积的结果
                    (fact (- x 1) (* acc x)) ; 否则调用自身 fact(x-1,acc*x)
                )
            )
            (result (n) ; 第二个局部函数
                (fact n 1) ; x 和 acc 的初始值分别为 n 和 1
            )
        )
        (result n)
    )
)

(format t "Factorial of 5 is: ~a~%" (factorial 5))
;;; Factorial of 5 is: 120

#||
fact 函数可以递归地调用自身，并使用局部变量 acc 保存累积的结果。
labels 允许这两个局部函数相互访问，从而计算阶乘。
||#

(labels ((double-it (num) 
            (* num 2))
        (dountri-it (num)
            (* (double-it num) 3)))
    (format t "Double & Triple 2 = ~d ~%" (dountri-it 2)))
;;; Double & Triple 2 = 12