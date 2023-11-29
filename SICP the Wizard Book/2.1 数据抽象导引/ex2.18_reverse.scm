(define (reverse items)
    (define (iter answer whats-left)
        (if (null? whats-left)
            answer
            (iter (cons (car whats-left) answer) (cdr whats-left))))
    (iter (list (car items)) (cdr items)))

(define test (list 1 4 9 16 25))

(reverse test)
;Value: (25 16 9 4 1)

(define test-2 (list 1 (list 2 3 4) 5 (list 6 7)))

test-2
;Value: (1 (2 3 4) 5 (6 7))

(reverse test-2)
;Value: ((6 7) 5 (2 3 4) 1)