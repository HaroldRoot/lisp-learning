#lang sicp

;;; 在检查某个项目是否存在时，我们不再需要扫描整个集合。
;;; 如果我们到达的集合元素大于我们要查找的项目，那么我们就知道该项目不在集合中：
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set 
                         (cdr set1)
                         (cdr set2))))
              ((< x1 x2) (intersection-set 
                          (cdr set1) 
                          set2))
              ((< x2 x1) (intersection-set 
                          set1 
                          (cdr set2)))))))

#|-----------------------------------------------|#

#||
(define (adjoin-set x set)
  (define (iter before-x x after-x)
    (cond ((null? after-x)
           (append before-x (list x)))
          ((> x (car after-x))
           (iter (append before-x (list (car after-x)))
                 x
                 (cdr after-x)))
          ((< x (car after-x))
           (append before-x
                   (append (list x) after-x)))
          ((= x (car after-x))
           set)))
  (iter '() x set))

(adjoin-set 3 (list 1 2 4 5))
; (1 2 3 4 5)

(adjoin-set 3 (list 1 2 3 4 5))
; (1 2 3 4 5)
||#

;;; 也许应该考虑不使用 append 的方法
(define (adjoin-set x set)
  (if (null? set)
      (list x)
      (let ((current-element (car set))
            (remaining-elements (cdr set)))
        (cond ((= x current-element)
               set)
              ((> x current-element)
               (cons current-element
                     (adjoin-set x remaining-elements)))
              ((< x current-element)
               (cons x set))))))

(adjoin-set 3 '())
; (3)

(adjoin-set 3 (list 1 2 4 5))
; (1 2 3 4 5)

(adjoin-set 3 (list 1 2 3 4 5))
; (1 2 3 4 5)