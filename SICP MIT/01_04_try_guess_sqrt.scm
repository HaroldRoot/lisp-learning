(define (try guess x)
    (if (good-enough? guess x)
        guess
        (try (improve guess x) x)))

(define (sqrt x) (try 1 x))

(define (improve guess x)
    (average guess (/ x guess)))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) .001))

;(define (square x) (* x x)) ; unnecessary, actually already built-in

(define (average x y) (/ (+ x y) 2))

;(define (abs x) ; unnecessary, actually already built-in
;    (if (< x 0) (- x) x))

(sqrt 2) ; 577/408