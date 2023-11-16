(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result 
            (iter (next a) (+ result (term a)))))
    (iter a 0))

(define (inc n) (+ n 1))
(define (new-sum-cubes a b)
    (sum cube a inc b))

(new-sum-cubes 1 10) ; 3025

(define (identity x) x)
(define (new-sum-integers a b)
    (sum identity a inc b))

(new-sum-integers 1 10) ; 55

(define (new-pi-sum a b)
    (define (pi-term x)
        (/ 1.0 (* x (+ x 2))))
    (define (pi-next x)
        (+ x 4))
    (sum pi-term a pi-next b))

(* 8 (new-pi-sum 1 1000)) ; 3.139592655589782 最后一位不一样
;; eg1.3.1_sum.scm 中的结果是 3.139592655589783