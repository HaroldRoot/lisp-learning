(define count 1)
(define (demo x)
    (set! count (1+ count))
    (+ x count))

(demo 3) ; 5

(demo 3) ; 6