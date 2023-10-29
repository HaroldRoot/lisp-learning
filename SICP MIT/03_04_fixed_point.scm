(define (sqrt x)
    (fixed-point 
        (lambda (y) (average (/ x y) y)) ; f(y)
        1)) ; 假定初始不动点的猜测值为 1

(define (fixed-point f start)
    (define tolerance 0.00001)
    (define (close-enuf? u v)
        (< (abs (- u v)) tolerance))
    (define (iter old new) ; 两个寄存器
        (if (close-enuf? old new)
            new 
            (iter new (f new))))
    (iter start (f start)))

