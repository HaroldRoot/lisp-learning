(load "common.rkt")
(load "make_table.rkt")

(define (install-exponentiation-package)
  ;; 内部过程
  ;; 选择函数
  (define base car) 
  (define exponent cadr) 
  ;; 构造函数
  (define (make-exponentiation base exponent) 
    (cond ((=number? base 0) 0) 
          ((=number? exponent 1) base) 
          ((=number? exponent 0) 1) 
          ((and (number? base) (number? exponent))  
           (expt base exponent)) 
          (else (list '** base exponent))))
  ;; 求导过程
  (define (exp-deriv operands var) 
    (make-product (exponent operands) 
                  (make-product (make-exponentiation (base operands) 
                                                     (- (exponent operands) 1)) 
                                (deriv (base operands) var))))
  ;; 对外接口
  (put 'deriv '** exp-deriv)
  'done)