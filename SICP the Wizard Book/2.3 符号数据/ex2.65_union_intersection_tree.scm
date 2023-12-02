#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;;; 时间复杂度 Θ(n)
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list 
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list 
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))

;;; 时间复杂度 Θ(n)
(define (list->tree elements)
  (car (partial-tree 
        elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size 
             (quotient (- n 1) 2)))
        (let ((left-result 
               (partial-tree 
                elts left-size)))
          (let ((left-tree 
                 (car left-result))
                (non-left-elts 
                 (cdr left-result))
                (right-size 
                 (- n (+ left-size 1))))
            (let ((this-entry 
                   (car non-left-elts))
                  (right-result 
                   (partial-tree 
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree 
                     (car right-result))
                    (remaining-elts 
                     (cdr right-result)))
                (cons (make-tree this-entry 
                                 left-tree 
                                 right-tree)
                      remaining-elts))))))))

;;; 使用练习 2.63 和练习 2.64 的结果，
;;; 为实现为（平衡）二叉树的集合提供 union-set
;;; 和 intersection-set 的 Θ(n) 实现。

#||
思路：给定一个用树表示的集合
- 把它转换成用列表表示
- 对表使用交集或并集
- 把结果表转换回树
每一步的时间复杂度都是 Θ(n)
所以整体时间复杂度也是 Θ(n) 
||#

;;; ex2.61_sets_as_ordered_lists.scm
(define (intersection-list list1 list2)
  (if (or (null? list1) (null? list2))
      '()
      (let ((x1 (car list1)) (x2 (car list2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-list 
                         (cdr list1)
                         (cdr list2))))
              ((< x1 x2) (intersection-list 
                          (cdr list1) 
                          list2))
              ((< x2 x1) (intersection-list 
                          list1 
                          (cdr list2)))))))

;;; ex2.62_ordered_union_set.scm
(define (union-list list1 list2)
  (cond ((and (null? list1) (null? list2))
         '())
        ((null? list1)
         list2)
        ((null? list2)
         list1)
        (else
         (let ((a (car list1))
               (b (car list2)))
           (cond ((= a b)
                  (cons a (union-list (cdr list1) (cdr list2))))
                 ((< a b)
                  (cons a (union-list (cdr list1) list2)))
                 ((> a b)
                  (cons b (union-list list1 (cdr list2)))))))))

#|-----------------------------------------------------------|#

(define (intersection-set tree1 tree2)
  (list->tree (intersection-list (tree->list tree1)
                                 (tree->list tree2))))

(define (union-set tree1 tree2)
  (list->tree (union-list (tree->list tree1)
                          (tree->list tree2))))

#|-----------------------------------------------------------|#

;;; 测试

(define test-tree-1 (list->tree (list 1 2 3 4 5)))

(define test-tree-2 (list->tree (list 1 3 5 7 9)))

; test-tree-1 ; (3 (1 () (2 () ())) (4 () (5 () ())))

; test-tree-2 ; (5 (1 () (3 () ())) (7 () (9 () ())))

; (tree->list test-tree-1) ; (1 2 3 4 5)

; (tree->list test-tree-2) ; (1 3 5 7 9)

(intersection-set test-tree-1 test-tree-2)
; (3 (1 () ()) (5 () ()))

(tree->list (intersection-set test-tree-1 test-tree-2))
; (1 3 5)

(union-set test-tree-1 test-tree-2)
; (4 (2 (1 () ()) (3 () ())) (7 (5 () ()) (9 () ())))

(tree->list (union-set test-tree-1 test-tree-2))
; (1 2 3 4 5 7 9)