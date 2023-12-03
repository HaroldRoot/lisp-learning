(load "SICP the Wizard Book/2.3 符号数据/eg2.3.2_simplify.scm")

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (make-product (exponent exp)
                                     (make-exponentiation (base exp)
                                                          (- (exponent exp) 1)))
                       (deriv (base exp) var)))   
        (else (error "unknown expression 
                      type: DERIV" exp))))

#||
用符号 ** 表示乘幂
(deriv '(** u n) 'x)
||#

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (make-exponentiation base exponent)
  (cond ((=number? base 0) 0)
        ((=number? base 1) 1)
        ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((and (number? base) (number? exponent)) 
         (expt base exponent))
        (else (list '** base exponent))))

(define (base exp)
  (cadr exp))

(define (exponent exp)
  (caddr exp))

;;; 测试

(deriv '(** x 0) 'x)
;Value: 0

(deriv '(** x 1) 'x)
;Value: 1

(deriv '(** x 2) 'x)
;Value: (* 2 x)

(deriv '(** x 3) 'x)
;Value: (* 3 (** x 2))