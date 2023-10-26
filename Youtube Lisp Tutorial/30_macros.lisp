(setq *print-case* :capitalize)

;;;; Macros 宏 macros generate code

(defvar *num* 2)
(defvar *num-2* 0)

(if (= *num* 2)
    (progn
        (setf *num-2* 2)
        (format t "*num-2* = ~d ~%" *num-2*)
    )
    (format t "Not equal to 2 ~%"))
;;; *num-2* = 2 

;;; 每次都要写 progn 很麻烦
;;; 用宏来解决

(defmacro ifit (condition &rest body)
    `(if ,condition (progn ,@body) (format t "Can't Drive ~%")
    ))
#||
宏使用反引号（backquote，`）定义模板，这允许在模板中插入表达式，而不进行求值。
if 表达式的条件部分 condition 被插入到模板中，但不进行求值。
如果 condition 为真，那么progn 表达式会被插入到 if 的then分支中，
    它会依次执行body中的所有形式。
如果 condition 为假，那么一个format表达式会被插入到 if 的else分支中，
    它将输出消息 "Can't Drive" 到标准输出。

&rest body 表示body参数将接收一个参数列表。
使用@符号告诉宏展开参数列表中的每个参数，
使其成为单独的表达式。这样，
你可以在宏的展开模板中正确处理每个参数，
而不是将整个参数列表作为一个整体。
||#

(defvar *age* 16)

(ifit (>= *age* 16)
    (print "You are over 16")
    (print "Time to Drive")
    (terpri))
#||
"You are over 16" 
"Time to Drive"
||#