#||
1.1.7 节的 sqrt 过程

(define (sqrt-iter guess x)
    (if (good-enough? guess x) 
        guess
        (sqrt-iter (improve guess x)
                   x)))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))
||#

#||
1.3.3 节的 fixed-point 过程

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))
||#

(define (iterative-improve good-enough? improve)
    (define (iter guess)
        (if (good-enough? guess)
            guess 
            (iter (improve guess))))
    iter)

#|------------------------------------------------------|#

;;; 重写 sqrt 过程

(define (average x y)
    (/ (+ x y) 2.0))

(define (sqrt x)
    (define (good-enough? guess)
        (< (abs (- (square guess) x)) 0.001))
    (define (improve guess)
        (average guess (/ x guess)))
    ((iterative-improve good-enough? improve) x))

(sqrt 2)
;Value: 1.4142156862745097

#|------------------------------------------------------|#

;;; 重写 fixed-point 过程

(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    (define (good-enough? guess)
        (< (abs (- guess (f guess))) tolerance))
    (define (improve guess)
        (f guess))
    ((iterative-improve good-enough? improve) first-guess))

(fixed-point cos 1.0)
;Value: .7390893414033927