#||
(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b))))

(define (product term a next b)
    (if (> a b)
        1
        (* (term a)
           (product term (next a) next b))))
||#

;;;; 更一般的概念：accumulate

(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value ; 所有项都用完时的基本值
        (combiner (term a) 
                  (accumulate combiner
                              null-value
                              term
                              (next a)
                              next
                              b))))
;;; combiner 过程描述如何将当前项与剩余各项的积累结果组合起来

(define (sum term a next b)
    (accumulate + 
                0 
                term 
                a 
                next 
                b))

(define (product term a next b)
    (accumulate *
                1 
                term
                a
                next
                b))

(define identity (lambda (x) x))

(sum identity 1 1+ 5) ; 15

(product identity 1 1+ 5) ; 120

#|-------------------------------------------------------------|#

#||
(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result 
            (iter (next a) (+ result (term a)))))
    (iter a 0))

(define (product-iter term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))))
    (iter a 1))
||#

;;; 迭代式 accumulate

(define (accumulate-iter combiner null-value term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a)
                  (combiner result (term a)))))
    (iter a null-value))

(define (sum-iter term a next b)
    (accumulate-iter + 
                     0 
                     term 
                     a 
                     next 
                     b))

(sum-iter identity 1 1+ 100) ; 5050