(define (fixed-point f start)
    (define tolerance 0.00001)
    (define (close-enuf? u v)
        (< (abs (- u v)) tolerance))
    (define (iter old new) ; 两个寄存器
        (if (close-enuf? old new)
            new 
            (iter new (f new))))
    (iter start (f start)))

(define (sqrt x)
    (newton (lambda (y) (- x (square y)))
            1))

(define (newton f guess)
    (define df (deriv f))
    (fixed-point
        (lambda (x) (- x (/ (f x) (df x))))
        guess))

(define deriv
    (lambda (f)
        (lambda (x)
            (/ (- (f (+ x dx))
                    (f x))
                dx))))

(define dx .000001)

(sqrt 2) ; 1.4142135623754424