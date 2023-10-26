(setq *print-case* :capitalize)

;;;; File I/O

(with-open-file (my-stream
                "test.txt"
                :direction :output
                :if-exists :supersede)
    (princ "Some random Text" my-stream))

(let ((in (open "test.txt" :if-does-not-exist nil)))
    (when in
        (loop for line = (read-line in nil)
        while line do (format t "~a~%" line))
        (close in)))
;;; Some random Text

#||
(with-open-file (my-stream "test.txt" :direction :output :if-exists :supersede) ...)
这个表达式用于创建一个名为 "test.txt" 的文件，并将其关联到变量 my-stream。
:direction :output 指定文件打开模式为输出，这意味着我们可以向文件写入数据。
:if-exists :supersede 意味着如果文件 "test.txt" 存在，则它将被覆盖，新内容将写入文件。
... 中的部分是一个临时文件写入的上下文，它指定了在 my-stream 中写入文本内容。

(princ "Some random Text" my-stream)
这行代码使用 princ 函数将文本 "Some random Text" 写入 my-stream 文件流，
这将在 "test.txt" 文件中创建或覆盖文本内容。

(let ((in (open "test.txt" :if-does-not-exist nil))) ...)
这个表达式创建了一个变量 in，并尝试打开文件 "test.txt" 以进行读取。
open 函数的 :if-does-not-exist nil 参数指示，
如果文件不存在，它将返回 nil，否则将返回一个文件流。

(when in ...)
这是一个条件控制结构，它检查 in 是否为非空（即文件是否成功打开）。

(loop for line = (read-line in nil) while line do (format t "~a~%" line))
这个代码块使用 loop 宏来从文件流 in 逐行读取文本。
for line = (read-line in nil) 部分初始化 line 变量为从文件中读取的一行文本。
while line 表示只要 line 非空（即还有可读取的行），就执行循环。
(format t "~a~%" line) 将读取的行文本输出到控制台。

(close in)
这行代码关闭了文件流 in，以释放文件资源。
||#