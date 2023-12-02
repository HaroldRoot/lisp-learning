#lang sicp

#||
;;; 如果记录集被实现为无序列表，我们可以使用
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key 
                 (key (car set-of-records)))
         (car set-of-records))
        (else 
         (lookup given-key 
                 (cdr set-of-records)))))
||#

;;; 练习 2.66：针对记录集被构造为二叉树并按键的数值排序的情况实现 lookup 过程。

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (key node)
  (car node))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key
            (key (entry set-of-records)))
         (entry set-of-records))
        ((< given-key
            (key (entry set-of-records)))
         (lookup given-key
                 (left-branch set-of-records)))
        ((> given-key
            (key (entry set-of-records)))
         (lookup given-key
                 (right-branch set-of-records)))))

#|------------------------------------------------|#

(define record-1 (list 7 'John))
(define record-2 (list 3 'Mary))
(define record-3 (list 19 'Tom))
(define record-4 (list 1 'Peter))
(define record-5 (list 5 'Jack))

(define test-set-of-records
  (make-tree record-1
             (make-tree record-2
                        (make-tree record-4 '() '())
                        (make-tree record-5 '() '()))
             (make-tree record-3 '() '())))

test-set-of-records
; ((7 John) ((3 Mary) ((1 Peter) () ()) ((5 Jack) () ())) ((19 Tom) () ()))

(lookup 5 test-set-of-records)
; (5 Jack)

(lookup 19 test-set-of-records)
; (19 Tom)

(lookup 67 test-set-of-records)
; #f