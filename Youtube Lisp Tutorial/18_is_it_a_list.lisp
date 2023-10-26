(setq *print-case* :capitalize)

(format t "Is it a list = ~a ~%" (listp '(batman superman)))
;;; Is it a list = T 
;;; listp 函数可以判断一个数据是否是一个列表

(format t "Is 3 in list = ~a ~%" (if (member 3 '(2 4 6)) 't nil))
;;; Is 3 in list = Nil
;;; member 函数可以判断一个元素是否在一个列表中

(append '(just) '(some) '(random words))
;;; append 函数可以将多个列表连接成一个新的列表
;;; 返回值为 (just some random words)

(defparameter *nums* '(2 4 6))
;;; 定义一个全局变量 *nums*，并将其值设为一个列表 (2 4 6)

(push 1 *nums*)
;;; push函数可以将一个元素插入到一个列表的开头，并修改原来的列表
;;; 修改 nums 的值为 (1 2 4 6)

(format t "2nd Item in list = ~a ~%" (nth 2 *nums*))
;;; 2nd Item in list = 4
;;; Lisp 中索引从 0 开始计数，所以索引 2 表示第三个元素