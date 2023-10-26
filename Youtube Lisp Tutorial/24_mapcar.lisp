(setq *print-case* :capitalize)

;;;; check multiple different items and run a function against them

(format t "A number ~a ~%" (mapcar #'numberp '(1 2 3 f g)))
;;; A number (T T T Nil Nil)

#|
(mapcar #'numberp '(1 2 3 f g))
这是mapcar函数的调用。
它的作用是将函数numberp应用于列表(1 2 3 f g)中的每个元素，
然后返回一个新的列表，其中包含了每个元素对应的numberp函数的结果。
numberp函数用于判断一个值是否是数值（数字）。
在这个特定情况下，mapcar会对列表中的每个元素执行numberp函数，
它的返回值将是(T T T NIL NIL)，因为前三个元素是整数，
而后两个元素f和g不是整数。

在Common Lisp中，#' 用于创建一个函数对象。
这是因为Lisp是一门函数式编程语言，函数在Lisp中也是第一类对象
（first-class citizens），因此可以像其他数据类型一样进行操作。
当你在mapcar中传递一个函数作为参数时，
你需要使用#' 来指示你正在引用一个函数对象。

具体来说，#' 在Lisp中用于将一个函数名转化为函数对象。
这是因为函数名在Lisp中实际上是一个符号，要引用一个函数对象，
你需要使用#' 来告诉Lisp将该符号解释为一个函数。

在mapcar函数的参数列表中，第一个参数是一个函数，
后面的参数通常是一个或多个列表，mapcar将该函数应用于这些列表中的元素。

mapcar的基本语法如下：
(mapcar function list1 &rest more-lists)
 |#