(define (sqrt x) 
    (define (average x y) (/ (+ x y) 2))
    (define (improve guess)
        (average guess (/ x guess)))
    (define (good-enough? guess)
        (< (abs (- (square guess) x)) .001)) ; abs and square are built-in
    (define (try guess)
        (if (good-enough? guess)
            guess
            (try (improve guess))))
    (try 1))

(sqrt 2) ; 577/408