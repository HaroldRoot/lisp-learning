(define (square-list items)
    (if (null? items)
        '()
        (cons (square (car items))
              (square-list (cdr items)))))

(define test (list 1 2 3 4))

(square-list test)
;Value: (1 4 9 16)

(define (map-square-list items)
    (map square items))

(map-square-list test)
;Value: (1 4 9 16)