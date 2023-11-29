(define (reverse items)
    (define (iter answer whats-left)
        (if (null? whats-left)
            answer
            (iter (cons (car whats-left) answer) (cdr whats-left))))
    (iter (list (car items)) (cdr items)))

(define x (list (list 1 2) (list 3 4)))

x
;Value: ((1 2) (3 4))

(reverse x)
;Value: ((3 4) (1 2))

#||
预期效果
(deep-reverse x)
((4 3) (2 1))
||#

(define (deep-reverse items)
    (map reverse (reverse items)))

(deep-reverse x)
;Value: ((4 3) (2 1))