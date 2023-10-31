;;;; case analysis
(define (deriv expression variable) ; 表达式，变量 dexp/dvar
    (cond ((constant? expression variable) 0) ; 表达式是否是常量表达式
          ((same-var? expression variable) 1) ; 表达式和变量相同
          ((sum? expression) ; 表达式是和式
            (make-sum (deriv (a1 expression) variable)
                      (deriv (a2 expression) variable)))
          ((product? expression) ; 表达式是乘式
            (make-sum
                (make-product (m1 expression)
                              (deriv (m2 expression) variable))
                (make-product (deriv (m1 expression) variable)
                              (m2 expression))))))

(define (constant? expression variable)
    (and (atom? expression) ; 表达式是原子的吗？原子表达式不可以再被细分
         (not (eq? expression variable)))) ; eq?是语言内置的基本过程，不用关心具体实现

(define (same-var? expression variable)
    (and (atom? expression)
         (eq? expression variable)))

(define (sum? expression)
    (and (not (atom? expression))
         (eq (car expression) '+))) ; 单引号'表示符号

#|
(define (make-sum a1 a2)
    (list '+ a1 a2))
|#

(define (make-sum a1 a2)
    (cond ((and (number? a1)
                (number? a2))
           (+ a1 a2))
          ((and (number? a1) (= a2 0)) a1)
          ((and (number? a2) (= a1 0)) a2)
          (else (list '+ a1 a2))))

(define a1 cadr)

(define a2 caddr)

(define (product? expression)
    (and (not (atom? expression))
         (eq? (car exp) '*)))

(define (make-product m1 m2)
    (list '* m1 m2))

(define m1 cadr)

(define m2 caddr)

(define foo ; a*x*x + b*x + c
    (list '+ (list '* 'a (list '* 'x 'x))
       (list '+ (list '* 'b 'x)
          'c)))

foo ; (+ (* a (* x x)) (+ (* b x) c))

(deriv foo 'x)