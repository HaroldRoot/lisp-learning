;;;; Factorial of n
;;;; n 的阶乘
;;;; Functional version
;;;; 函数式版本
(define (fact n)
    (define (iter m i)
        (cond ((> i n) m)
              (else (iter (* i m) (+ i 1)))))
    (iter 1 1))

(fact 1) ; 1

(fact 2) ; 2

(fact 3) ; 6

(fact 4) ; 24

(fact 5) ; 120