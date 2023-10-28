(define (+ x y)
    (if (= x 0)
    y
    (1+ (+ (-1+ x) y))))