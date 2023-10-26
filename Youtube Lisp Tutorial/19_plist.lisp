(setq *print-case* :capitalize)

;;;; A property list (plist for short) is a list of paired elements.

(defvar superman (list :name "Superman" :secret-id "Clark Kent"))
;;; 键值对，name是键，"Superman"是值

(defvar *hero-list* nil)

(push superman *hero-list*)

(dolist (hero *hero-list*)
    (format t "~{~a : ~a ~}~%" hero))
;;; Name : Superman Secret-Id : Clark Kent
;;; 使用 dolist 函数，遍历 *hero-list* 列表中的每个元素（即每个英雄）
;;; 使用 format 函数，将每个英雄的信息按照指定的格式输出到标准输出流
#|
~{ 和 }~ 是Lisp语言中的格式控制符，它们的作用是对一个列表进行迭代，
即重复执行格式控制符中的内容，直到列表耗尽为止。
例如，如果我们有一个列表(1 2 3)，并且使用~{~a ~}来格式化它，
那么输出结果就是1 2 3 ，因为每个元素都用~a来输出，并且在后面加上一个空格。
 |#