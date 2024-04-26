(load "make_table.rkt")
(load "sum_pkg.rkt")
(load "product_pkg.rkt")
(load "exp_pkg.rkt")

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) 
         (if (same-variable? exp var) 
             1 
             0))
        (else ((get 'deriv (operator exp)) 
               (operands exp)
               var))))

(install-sum-package)
(install-product-package)
(install-exponentiation-package)

(deriv '(+ x x) 'x) ; 2
(deriv '(* x x) 'x) ; '(+ x x)
(deriv '(+ x (* x  (+ x (+ y 2)))) 'x) ; '(+ 1 (+ x (+ x (+ y 2))))
(deriv '(** x 3) 'x) ; '(* 3 (** x 2))