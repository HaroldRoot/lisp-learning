;;; 来自 eg1.2.6_smallest_divisor.scm

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond 
          ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
    (= (remainder b a) 0))

(smallest-divisor 199)
;Value: 199

(smallest-divisor 1999)
;Value: 1999

(smallest-divisor 19999)
;Value: 7

(smallest-divisor 199999)
;Value: 199999

(smallest-divisor 1999999)
;Value: 17

(smallest-divisor 19999999)
;Value: 19999999

(smallest-divisor 199999999)
;Value: 89

(smallest-divisor 1999999999)
;Value: 31