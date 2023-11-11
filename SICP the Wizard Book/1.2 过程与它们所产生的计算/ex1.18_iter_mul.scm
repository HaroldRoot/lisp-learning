#||
(define (iter-expt b n)
    (define (iter a b n)
        (cond ((= n 0) a)
              ((even? n) (iter a (square b) (/ n 2)))
              (else (iter (* a b) b (- n 1)))))
    (iter 1 b n))
||#

(define (double a)
    (+ a a))

(define (halve a)
    (/ a 2))


(define (mul a b)
    (define (iter res a b)
        (cond ((= b 0) res)
              ((even? b) (iter res (double a) (halve b)))
              ((odd? b) (iter (+ res a) a (- b 1)))))
    (iter 0 a b))

(mul 6 7) ; 42