(define tolerance 0.00001)

(define (average x y)
    (/ (+ x y) 2.0))

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                (begin (display next)
                       (display ". Search finished!") 
                       next)
                (begin (display guess)
                       (display ", ")
                       (try next)))))
    (try first-guess))

(define (sqrt x)
    (fixed-point (lambda (y) (average y (/ x y)))
                 1.0))

(sqrt 2)
; 1., 1.5, 1.4166666666666665, 1.4142135623746899. Search finished!