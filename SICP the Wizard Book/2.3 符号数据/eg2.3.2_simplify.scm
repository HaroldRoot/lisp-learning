(load "SICP the Wizard Book/2.3 符号数据/eg2.3_2_symbolic_differentiation.scm")

;;; 修改 make-sum，使得当两个求和对象都是数时，make-sum 求出它们的和返回
;;; 可以覆盖掉 load 进来的旧 make-sum 过程！
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

;;; 修改 make-product，设法引进下面的规则：
;;; 0 与任何东西的乘积都是 0
;;; 1 与任何东西的乘积总是那个东西
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list '* m1 m2))))

(deriv '(+ x 3) 'x)
;Value: 1

(deriv '(* x y) 'x)
;Value: y

(deriv '(* (* x y) (+ x 3)) 'x)
;Value: (+ (* x y) (* y (+ x 3)))