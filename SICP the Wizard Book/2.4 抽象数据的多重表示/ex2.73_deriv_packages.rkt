#lang racket

;;; 构建表格
(define *the-table* (make-hash))

(define (put op type item)
  (hash-set! *the-table*
             (list op type)
             item))

(define (get op type)
  (hash-ref *the-table*
            (list op type)
            #f))

#|--------------------------------------------------|#

;;; 尝试将 ex2.73_(runnable)_deriv.rkt 中的
;;; (install-symbolic-differentiation-package)
;;; 分散成三个包

(define (install-sum-package)
  (define (addend s) (car s)) 
  (define (augend s) 
    (if (null? (cddr s)) 
        (cadr s) 
        (cons '+ (cdr s))))
  (define (make-sum a1 a2) 
    (cond ((=number? a1 0) a2) 
          ((=number? a2 0) a1) 
          ((and (number? a1) (number? a2))  
           (+ a1 a2)) 
          (else (list '+ a1 a2)))) 
  (put 'deriv '+ (lambda (operands var) 
                   (make-sum (deriv (addend operands) var) 
                             (deriv (augend operands) var))))
  'done)

(define (install-product-package)
  (define (multiplier p) (car p)) 
  (define (multiplicand p) 
    (if (null? (cddr p)) 
        (cadr p)
        (cons '* (cdr p))))
  (define (make-product m1 m2) 
    (cond ((or (=number? m1 0)  
               (=number? m2 0))  
           0) 
          ((=number? m1 1) m2) 
          ((=number? m2 1) m1) 
          ((and (number? m1) (number? m2))  
           (* m1 m2)) 
          (else (list '* m1 m2))))
  ; 这里必须定义 make-sum
  ; 下面调用 put 过程时 需要用到 make-sum
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2) 
          ((=number? a2 0) a1) 
          ((and (number? a1) (number? a2))  
           (+ a1 a2)) 
          (else (list '+ a1 a2))))
  (put 'deriv '* (lambda (operands var) 
                   (make-sum 
                    (make-product  
                     (multiplier operands) 
                     (deriv (multiplicand operands) var)) 
                    (make-product  
                     (deriv (multiplier operands) var) 
                     (multiplicand operands)))))
  'done)

(define (install-exponentiation-package)
  (define base car) 
  (define exponent cadr) 
  (define (make-exponentiation base exponent) 
    (cond ((=number? base 0) 0) 
          ((=number? exponent 1) base) 
          ((=number? exponent 0) 1) 
          ((and (number? base) (number? exponent))  
           (expt base exponent)) 
          (else (list '** base exponent))))
  ; 这里必须定义 make-product
  ; 下面调用 put 过程时 需要用到 make-product
  (define (make-product m1 m2) 
    (cond ((or (=number? m1 0)  
               (=number? m2 0))  
           0) 
          ((=number? m1 1) m2) 
          ((=number? m2 1) m1) 
          ((and (number? m1) (number? m2))  
           (* m1 m2)) 
          (else (list '* m1 m2)))) 
  (put 'deriv '** (lambda (operands var) 
                    (make-product (exponent operands) 
                                  (make-product (make-exponentiation (base operands) 
                                                                     (- (exponent operands) 1)) 
                                                (deriv (base operands) var)))))
  'done)

#|--------------------------------------------------|#

(define (variable? x) (symbol? x)) 
  
(define (same-variable? v1 v2) 
  (and (variable? v1) 
       (variable? v2) 
       (eq? v1 v2))) 
  
(define (=number? exp num) 
  (and (number? exp) (= exp num))) 

#|--------------------------------------------------|#

(define (deriv exp var) 
  (cond ((number? exp) 0) 
        ((variable? exp)  
         (if (same-variable? exp var)  
             1  
             0)) 
        (else ((get 'deriv (operator exp))  
               (operands exp)  
               var)))) 
  
(define (operator exp) (car exp)) 
(define (operands exp) (cdr exp))

#|--------------------------------------------------|#

(install-sum-package)
(install-product-package)
(install-exponentiation-package)
(deriv '(+ x x x) 'x) ; 3
(deriv '(* x x x) 'x) ; '(+ (* x (+ x x)) (* x x))
(deriv '(+ x (* x  (+ x (+ y 2)))) 'x) ; '(+ 1 (+ x (+ x (+ y 2))))
(deriv '(** x 3) 'x) ; '(* 3 (** x 2))