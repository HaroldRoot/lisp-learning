#||
~a 表示将参数按照其自身的打印方式输出
~s 表示将参数按照其读取方式输出。
    这通常会在字符串两边加上双引号，而在符号两边加上竖线。
~10a 表示将参数按照其自身的打印方式输出，
    并且占用 10 个字符的宽度。
    如果参数的长度小于 10，则会在右边补上空格。
~10@a 表示将参数按照其自身的打印方式输出，
    并且占用 10 个字符的宽度。
    如果参数的长度小于 10，则会在左边补上空格。
||#

(format t "~a" "Apple")
(format t "~%")
(format t "~a" 1.00)
(format t "~%")
(format t "~a" '(1 0 0))
(format t "~%")
#||
Apple
1.0
(1 0 0)
||#

(format t "~s" "Boy") 
(format t "~%")
(format t "~s" 2.00) 
(format t "~%")
(format t "~s" '(2 0 0)) 
(format t "~%")
(format t "~s" '|Boy|) 
(format t "~%")
#||
"Boy"
2.0
(2 0 0)
|Boy|
||#


(format t "~10a" "Cat") 
(format t "~%")
(format t "~10a" 3.00) 
(format t "~%")
(format t "~10a" '(3 0 0)) 
(format t "~%")
#||
Cat       
3.0       
(3 0 0)   
||#

(format t "~10@a" "Dog") 
(format t "~%")
(format t "~10@a" 4.00)  
(format t "~%")
(format t "~10@a" '(4 0 0))  
(format t "~%")
#||
       Dog
       4.0
   (4 0 0)
||#