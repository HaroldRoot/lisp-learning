;;; 使用 map 和递归定义
(define (square-tree tree)
    (map (lambda (sub-tree)
            (if (pair? sub-tree)
                (square-tree sub-tree)
                (square sub-tree)))
         tree))

(square-tree (list 1 (list 2 (list 3 4) 5 (list 6 7))))
;Value: (1 (4 (9 16) 25 (36 49)))

;;; 直接定义，不使用任何高阶函数
(define (s-t tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (square tree))
          (else (cons (s-t (car tree))
                      (s-t (cdr tree))))))

(s-t (list 1 (list 2 (list 3 4) 5 (list 6 7))))
;Value: (1 (4 (9 16) 25 (36 49)))