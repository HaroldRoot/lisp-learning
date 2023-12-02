;;; 带权重元素的集合
;;; 构造集合，按照权重的升序排列表中的元素
;;; 不允许重复元素
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) 
         (cons x set))
        (else 
         (cons (car set)
               (adjoin-set x (cdr set))))))

;;; 构造叶子集合
;;; 参数：由（符号-权重）序对组成的表
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set 
         (make-leaf (car pair)    ; 符号
                    (cadr pair))  ; 频率（权重）
         (make-leaf-set (cdr pairs))))))