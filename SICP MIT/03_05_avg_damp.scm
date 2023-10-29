(define (fixed-point f start)
    (define tolerance 0.00001)
    (define (close-enuf? u v)
        (< (abs (- u v)) tolerance))
    (define (iter old new) ; 两个寄存器
        (if (close-enuf? old new)
            new 
            (iter new (f new))))
    (iter start (f start)))

#||
(define (sqrt x)
    (fixed-point 
        (lambda (y) (average (/ x y) y)) ; f(y)
        1)) ; 假定初始不动点的猜测值为 1
||#

(define (sqrt x)
    (fixed-point 
        (average-damp (lambda (y) (/ x y)))
        1))

(define average-damp
    (lambda (f)
        (lambda (x) (average (f x) x))))

#||
等价写法：
(define (average-damp f)
        (lambda (x) (average (f x) x)))

另一种等价写法，但是得另写一个冗余的变量名 foo：
(define (average-damp f)
    (define (foo x)
        (average x (f x)))
    foo)
||#

