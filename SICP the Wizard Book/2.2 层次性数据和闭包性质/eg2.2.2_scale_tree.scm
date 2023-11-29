(define (scale-tree tree factor)
    (cond ((null? tree) '())
          ((not (pair? tree)) (* tree factor))
          (else (cons (scale-tree (car tree) factor)
                      (scale-tree (cdr tree) factor)))))

(define test (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(scale-tree test 10)
;Value: (10 (20 (30 40) 50) (60 70))

(define (map-scale-tree tree factor)
    (map (lambda (sub-tree)
            (if (pair? sub-tree)
                (map-scale-tree sub-tree factor)
                (* sub-tree factor)))
         tree))

