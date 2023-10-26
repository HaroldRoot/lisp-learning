(setq *print-case* :capitalize)

(defparameter *hero-size*
    '((Superman (6 ft 3 in) (230 lbs))
    (Flash (6 ft 0 in) (190 lbs))
    (Batman (6 ft 2 in) (210 lbs))))

(defun get-hero-data (size)
    (format t "~a ~%"
    `(,(caar size) is ,(cadar size) and ,(cddar size))))
#|
这是一个用于构建输出字符串的嵌套表达式。
它从 size 参数中提取超级英雄的名称、身高和体重信息，
并以特定格式输出。
 |#

(get-hero-data *hero-size*)
;;; (Superman Is (6 Ft 3 In) And ((230 Lbs))) 

#|
Quasi-quoting（准引用）是一种编程语言中的文本处理技术，
通常用于简化代码生成、模板引擎、宏展开和元编程等方面。
它允许你在文本中插入代码片段，同时保持文本的结构，
以便在需要时执行这些代码片段。
准引用的概念最常见于Lisp编程语言及其方言。

在Lisp中，准引用使用反引号（backtick `）来表示，
并且可以与逗号（comma ,）结合使用
来引用和插入变量、表达式和代码片段。
基本思想是，通过准引用，你可以构建一个数据结构，
同时允许在其中插入Lisp表达式，而不需要手动构建复杂的嵌套结构。

以下是准引用在Lisp中的基本用法：
反引号（`）用于启用准引用。
逗号（,）用于插入一个值或表达式。
 |#

(format t "~a ~%" (let ((x 10) (y 20))
    `(x is ,x and y is ,y)))
;;; (X Is 10 And Y Is 20) 

#|
这是一个 let 表达式，它用于创建一个局部变量环境。
在这个环境中，定义了两个局部变量 x 和 y，
并为它们分别赋值为 10 和 20。

let 的基本语法如下：
(let ((var1 val1) (var2 val2) ... (varn valn))
  body)
var1, var2, ..., varn 是局部变量的名称，它们可以是符号（symbols）。
val1, val2, ..., valn 是与相应变量绑定的初始值。
body 是在这些局部变量绑定下执行的表达式。
let 允许你在 body 部分中使用这些局部变量，
这些变量的作用范围仅限于 let 表达式的 body 部分。
当 let 表达式执行完毕后，这些局部变量的绑定会被销毁。
let 的返回值是其 body 部分的最后一个表达式的值。
如果 body 部分包含多个表达式，那么它将返回最后一个表达式的值。
如果 body 部分为空，那么 let 表达式将返回 nil。
 |#