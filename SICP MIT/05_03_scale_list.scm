;;; CDR-ing down a list
(define (scale-list s l)
    (if (null? l)
        '()
        (cons (* (car l) s)
              (scale-list s (cdr l)))))
;; scale-list

(define 1-to-4 (list 1 2 3 4))
;; |1-to-4|

(scale-list 10 1-to-4)
;; (10 20 30 40)