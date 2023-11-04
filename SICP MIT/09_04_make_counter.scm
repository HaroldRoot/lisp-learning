(define make-counter
    (lambda (n)
        (lambda ()
            (set! n (1+ n))
            n)))

(define c1 (make-counter 0))

(define c2 (make-counter 10))

(c1) ; 1

(c2) ; 11

(c1) ; 2

(c2) ; 12