(load "common.rkt")
(load "make_table.rkt")

(define (install-sum-package)
  ;; 内部过程
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (sum-deriv exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  ;; 对外接口
  (put 'deriv '+ sum-deriv)
  'done)