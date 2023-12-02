#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

;;; 将有序表转换为平衡二叉树
(define (list->tree elements)
  (car (partial-tree 
        elements (length elements))))

;;; 辅助函数
;;; 整数 n，一个至少包含 n 个元素的表 elts
;;; 构造出一棵包含这个表的前 n 个元素的平衡树
;;; 返回一个序对，car 是构造出的树，cdr 是没有包含在树中的那些元素的表
(define (partial-tree elts n)
  (if (= n 0) ; 如果 n 等于 0，说明不需要构造树
      (cons '() elts) ; 返回一个序对，car 是空表，cdr 是原始表
      (let ((left-size 
             (quotient (- n 1) 2))) ; 否则，计算左子树的大小，为 (n-1)/2
        (let ((left-result 
               (partial-tree 
                elts left-size))) ; 递归地调用 partial-tree 函数，构造左子树，返回一个序对，car 是左子树，cdr 是剩余的元素表
          (let ((left-tree 
                 (car left-result)) ; 取出左子树
                (non-left-elts 
                 (cdr left-result)) ; 取出剩余的元素表
                (right-size 
                 (- n (+ left-size 1)))) ; 计算右子树的大小，为 n - (left-size + 1)
            (let ((this-entry 
                   (car non-left-elts)) ; 取出剩余元素表的第一个元素，作为根节点
                  (right-result 
                   (partial-tree 
                    (cdr non-left-elts)
                    right-size))) ; 递归地调用 partial-tree 函数，构造右子树，返回一个序对，car 是右子树，cdr 是剩余的元素表
              (let ((right-tree 
                     (car right-result)) ; 取出右子树
                    (remaining-elts 
                     (cdr right-result))) ; 取出剩余的元素表
                (cons (make-tree this-entry 
                                 left-tree 
                                 right-tree) ; 使用 make-tree 函数，根据根节点、左子树和右子树构造一棵树
                      remaining-elts)))))))) ; 返回一个序对，car 是构造出的树，cdr 是剩余的元素表

;;; a)
(list->tree (list 1 3 5 7 9 11))
; (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))
#||
         5
        / \
       /   \
      /     \
     /       \
    1         9
   / \       / \
  /   \     /   \
'()    3   7    11
||#