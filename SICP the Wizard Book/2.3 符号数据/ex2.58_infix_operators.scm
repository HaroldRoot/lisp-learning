#lang sicp

;;;; a)

;;; 抽象数据的微分程序
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
        (else (error "unknown expression 
                      type: DERIV" exp))))

;;; 表示代数表达式

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

#||
由于微分程序是
根据抽象数据定义的，我们可以仅通过
更改定义微分器要操作的代数表达式的
表示形式的谓词、选择函数和构造函数
来修改它以处理表达式的不同表示形式
||#

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list a1 '+ a2)))) ; 修改这里

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list m1 '* m2)))) ; 修改这里

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+))) ; 修改这里

(define (addend s) (car s)) ; 修改这里

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*))) ; 修改这里

(define (multiplier p) (car p)) ; 修改这里

(define (multiplicand p) (caddr p))

;;; 测试

(deriv '(x + (3 * (x + (y + 2)))) 'x)
; 4

(deriv '(x * y) 'x)
; y

(deriv '((x * y) * (x + 3)) 'x)
; ((x * y) + (y * (x + 3)))

;;;; b)

#||
谓词、选择函数和构造函数
无法确保乘法在加法之前完成，
需要修改 deriv 函数才可能
让它能够处理符号的优先级。
否则就会出现「二义性文法」。
||#