#lang sicp

;;; element-of-set? 类似于 2.3.1 的过程 memq 。
;;; 它使用 equal? 而不是 eq? ，因此集合元素不必是符号:
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

#||
(define (memq item x)
    (cond ((null? x) false)
          ((eq? item (car x)) x)
          (else (memq item (cdr x)))))
||#

;;; 如果要连接的对象已经在集合中，我们就返回集合。
;;; 否则，我们使用 cons 将对象添加到表示集合的列表中：
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

;;; 交集
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) 
         '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) 
                                 set2)))
        (else (intersection-set (cdr set1) 
                                set2))))

(intersection-set '(1 2 3) '(3 4 5 6))
; (3)

(intersection-set '() '(1 2 3))
; ()