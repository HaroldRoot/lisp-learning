#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;;; 使用 append 操作来连接左子树、根节点和右子树的表
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append 
       (tree->list-1 
        (left-branch tree))
       (cons (entry tree)
             (tree->list-1 
              (right-branch tree))))))

(define left-node (make-tree 1 '() '()))
(define right-node (make-tree 3 '() '()))
(define top-node (make-tree 2 left-node right-node))

(define test-1 (tree->list-1 top-node))
(display test-1) ; (1 2 3)
(newline)

;;; 使用 result-list 参数来累积结果表
(define (tree->list-2 tree)
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

(define test-2 (tree->list-2 top-node))
(display test-2)
(newline)
(newline)

#||
这两种策略的效率不同。

append 操作的时间复杂度是 O(n)，其中 n 是第一个参数的长度。
所以，tree->list-1 过程的时间复杂度是 O(n^2)，其中 n 是树中的节点数。

而 result-list 参数的时间复杂度是 O(1)，因为只需要 cons 一次。
所以，tree->list-2 过程的时间复杂度是 O(n)。

因此，tree->list-2 过程比 tree->list-1 过程更高效，也更符合函数式编程的风格。
||#

#|-----------------------------------------------|#

;;; 测试图 2-16 中的那些树
(define tree-1
  (make-tree 7
             (make-tree 3
                        (make-tree 1 '() '())
                        (make-tree 5 '() '()))
             (make-tree 9
                        '()
                        (make-tree 11 '() '()))))

(define tree-2
  (make-tree 3
             (make-tree 1 '() '())
             (make-tree 7
                        (make-tree 5 '() '())
                        (make-tree 9
                                   '()
                                   (make-tree 11 '() '())))))

(define tree-3
  (make-tree 5
             (make-tree 3
                        (make-tree 1 '() '())
                        '())
             (make-tree 9
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))


(display (tree->list-1 tree-1))
(newline)
(display (tree->list-1 tree-2))
(newline)
(display (tree->list-1 tree-3))
(newline)
(newline)
; 上面的输出都是 (1 3 5 7 9 11)

(display (tree->list-2 tree-1))
(newline)
(display (tree->list-2 tree-2))
(newline)
(display (tree->list-2 tree-3))
(newline)
; 上面的输出都是 (1 3 5 7 9 11)