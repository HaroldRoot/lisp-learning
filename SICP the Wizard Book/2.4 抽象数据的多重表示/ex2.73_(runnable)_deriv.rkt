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

;;; 程序包 package
(define (install-symbolic-differentiation-package) 
  ;;; 加式
  ;; 选择函数
  ; 注意参数 s 是剥去了符号的 (operands exp)
  ; 所以 (car s) 并不是符号，而直接是第一个运算对象
  (define (addend s) (car s)) 
  (define (augend s) 
    (if (null? (cddr s)) 
        (cadr s) 
        (cons '+ (cdr s))))
  ;; 构造函数
  (define (make-sum a1 a2) 
    (cond ((=number? a1 0) a2) 
          ((=number? a2 0) a1) 
          ((and (number? a1) (number? a2))  
           (+ a1 a2)) 
          (else (list '+ a1 a2)))) 
  ;; 接口
  (put 'deriv '+ (lambda (operands var) 
                   (make-sum (deriv (addend operands) var) 
                             (deriv (augend operands) var)))) 

  ;;; 乘式
  ;; 选择函数
  (define (multiplier p) (car p)) 
  (define (multiplicand p) 
    (if (null? (cddr p)) 
        (cadr p)
        (cons '* (cdr p))))
  ;; 构造函数
  (define (make-product m1 m2) 
    (cond ((or (=number? m1 0)  
               (=number? m2 0))  
           0) 
          ((=number? m1 1) m2) 
          ((=number? m2 1) m1) 
          ((and (number? m1) (number? m2))  
           (* m1 m2)) 
          (else (list '* m1 m2)))) 
  ;; 接口
  (put 'deriv '* (lambda (operands var) 
                   (make-sum 
                    (make-product  
                     (multiplier operands) 
                     (deriv (multiplicand operands) var)) 
                    (make-product  
                     (deriv (multiplier operands) var) 
                     (multiplicand operands))))) 

  ;;; 幂式
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
  ;; 接口
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

;;; 测试
  
(install-symbolic-differentiation-package) 
(deriv '(+ x x x) 'x) ; 3
(deriv '(* x x x) 'x) ; '(+ (* x (+ x x)) (* x x))
(deriv '(+ x (* x  (+ x (+ y 2)))) 'x) ; '(+ 1 (+ x (+ x (+ y 2))))
(deriv '(** x 3) 'x) ; '(* 3 (** x 2))