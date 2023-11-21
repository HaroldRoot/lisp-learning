;;;; 逼近三次方程 x^3 + ax^2 + bx + c 的零点

;;; (newtons-method (cubic a b c) 1)

#|---------------------------------------------|#

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

(define dx 0.00001)

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
           dx)))

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

(define (fixed-point-of-transform g transform guess)
    (fixed-point (transform g) guess))

#|---------------------------------------------|#

(define (newtons-method g first-guess)
    (fixed-point-of-transform g
                              newton-transform
                              first-guess))

#|---------------------------------------------|#

(define (cubic a b c)
    (lambda (x)
        (+ (* x x x)
           (* a x x)
           (* b x)
           c)))

#|---------------------------------------------|#

(newtons-method (cubic 1 2 3) 1)
;Value: -1.2756822036498454

((cubic 1 2 3) (newtons-method (cubic 1 2 3) 1))
;Value: 4.935607478273596e-12

((cubic 1 2 3) 1)
;Value: 7