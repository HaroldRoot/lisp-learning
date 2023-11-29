#||
;;; ex2.30_tree_map.scm
(define (square-tree tree)
    (map (lambda (sub-tree)
            (if (pair? sub-tree)
                (square-tree sub-tree)
                (square sub-tree)))
         tree))
||#

(define (square-tree tree)
    (tree-map square tree))

(define (tree-map proc tree)
    (map (lambda (sub-tree)
            (if (pair? sub-tree)
                (tree-map proc sub-tree)
                (proc sub-tree)))
            tree))
;;;测试
(square-tree (list 1 (list 2 (list 3 4) 5 (list 6 7))))
;Value: (1 (4 (9 16) 25 (36 49)))

(define (double-tree tree)
    (tree-map (lambda (x) (* x 2)) tree))

(double-tree (list 1 (list 2 (list 3 4) 5 (list 6 7))))
;Value: (2 (4 (6 8) 10 (12 14)))