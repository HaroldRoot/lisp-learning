#lang sicp

#||
用表 lists 来表示树 trees 
将结点 node 表示为三个元素的表:
- 本结点中的数据项 the entry at the node
- 左子树 the left subtree
- 右子树 the right subtree
||#

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;;; 搜索规模为 n 的树所需的步数会以 Θ(log n) 速度增长
;;; 现在我们可以使用上述策略编写 element-of-set? 过程：
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? 
          x 
          (left-branch set)))
        ((> x (entry set))
         (element-of-set? 
          x 
          (right-branch set)))))

;;; 向集合里加入一个项的实现方式也需要 Θ(log n) 步数
(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree 
          (entry set)
          (adjoin-set x (left-branch set))
          (right-branch set)))
        ((> x (entry set))
         (make-tree
          (entry set)
          (left-branch set)
          (adjoin-set x (right-branch set))))))

;;; 感觉很奇怪，这样的写法不平衡，测试一下
(define test-set-1 (make-tree 1 '() '()))
(define test-set-2 (adjoin-set 2 test-set-1))
(define test-set-3 (adjoin-set 3 test-set-2))
(define test-set-4 (adjoin-set 4 test-set-3))
(define test-set-5 (adjoin-set 5 test-set-4))
(define test-set-6 (adjoin-set 6 test-set-5))
(define test-set-7 (adjoin-set 7 test-set-6))

(display test-set-7)
; (1 () (2 () (3 () (4 () (5 () (6 () (7 () ())))))))
; 这就得到了 Figure 2.17: Unbalanced tree produced by adjoining 1 through 7 in sequence.
; 图 2-17 通过顺序加入 1 到 7 产生的非平衡树