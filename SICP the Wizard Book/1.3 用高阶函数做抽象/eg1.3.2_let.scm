#||
a=1+xy
b=1-y
f(x,y)=xa^2+yb+ab
||#

;;; 利用辅助过程区约束局部变量
(define (f1 x y)
    (define (f-helper a b)
        (+ (* x (square a))
           (* y b)
           (* a b)))
    (f-helper (+ 1 (* x y))
              (- 1 y)))

;;; 使用 lambda 表达式
(define (f2 x y)
    ((lambda (a b)
        (+ (* x (square a))
           (* y b)
           (* a b))) ; 匿名过程描述结束
        (+ 1 (* x y)) ; 接受第一个参数 a
        (- 1 y))) ; 接受第二个参数 b

;;; 特殊形式 let
(define (f3 x y)
    (let ((a (+ 1 (* x y))) ; <var1> <exp1>
          (b (- 1 y))) ; <var2> <exp2>
        (+ (* x (square a)) ; <body>
           (* y b)
           (* a b))))

;;; 测试
(f1 6 7) ; 10794
(f2 6 7) ; 10794
(f3 6 7) ; 10794

;;; let 表达式描述的变量的作用域就是该 let 的体

(define (test1 x)
    (+ (let ((x 3))
        (+ x (* x 10)))
       x))

(test1 5) ; 38
#||
先把 x=3 代入 x+x*10 得到 33
再把 33 和外部的 x(=5) 相加，得 38
||#

;;; <var> 的值是在 let 之外计算的

(define (test2 x)
    (let ((x 3)
          (y (+ x 2)))
        (* x y)))

(test2 2) ; 12
#||
(y (+ x 2)) 是把 y 定义成外部的 x(=2)+2=4
(* x y) 是用内部的 x(=3) 乘以 y(=4)，所以得 12
||#