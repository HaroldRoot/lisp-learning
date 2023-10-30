(define (map p l) ; p - procedure, l - list
    (if (null? l)
        '()
        (cons (p (car l)) ; apply p to first element
              (map p (cdr l))))) ; map down the rest of the list

(define (scale-list s l)
    (map (lambda (item) (* item s)) 
         l))

(define 1-to-4 (list 1 2 3 4))
;; |1-to-4|

(scale-list 5 1-to-4)
;; (5 10 15 20)

(map square 1-to-4)
;; (1 4 9 16)

(map (lambda (x) (+ x 10)) 1-to-4)
;; (11 12 13 14)