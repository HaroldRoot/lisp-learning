(cons 1
    (cons 2
        (cons 3
            (cons 4 '()))))
;; (1 2 3 4)

(list 1 2 3 4) ; 语法糖
;; (1 2 3 4)

(define 1-to-4 (list 1 2 3 4))
;; |1-to-4|

(car (cdr 1-to-4))
;; 2

(car (cdr (cdr 1-to-4)))
;; 3

1-to-4
;; (1 2 3 4)

(cdr 1-to-4)
;; (2 3 4)

(cdr (cdr 1-to-4))
;; (3 4)

(cdr (cdr (cdr (cdr 1-to-4))))
;; ()