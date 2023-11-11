(define (fib n)
    (fib-iter 1 0 n))

(define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))

(fib 5) ; 5
#||
(fib 5)
(fib-iter 1 0 5)
(fib-iter (1+0) 1 (5-1))
(fib-iter 1 1 4)
(fib-iter (1+1) 1 (4-1))
(fib-iter 2 1 3)
(fib-iter (2+1) 2 (3-1))
(fib-iter 3 2 2)
(fib-iter (3+2) 3 (2-1))
(fib-iter 5 3 1)
(fib-iter (5+3) 5 (1-1))
(fib-iter 8 5 0)
5
||#