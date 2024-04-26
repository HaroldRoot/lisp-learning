(load "common.rkt")
(load "make_table.rkt")

(define (install-product-package)
  ;; 内部过程
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (product-deriv exp var)
    (make-sum
     (make-product 
      (multiplier exp)
      (deriv (multiplicand exp) var))
     (make-product 
      (deriv (multiplier exp) var)
      (multiplicand exp))))
  ;; 对外接口
  (put 'deriv '* product-deriv)
  'done)