#lang sicp

(define (single-operand? term-list)
  (= (length term-list) 1))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 . a2)
  (if (single-operand? a2)
      (let ((a2 (car a2)))
        (cond ((=number? a1 0)
               a2)
              ((=number? a2 0)
               a1)
              ((and (number? a1) (number? a2))
               (+ a1 a2))
              (else
               (list '+ a1 a2))))
      (cons '+ (cons a1 a2))))

;(make-sum 6 7)
;13

;(make-sum 6 7 0)
;(+ 6 7 0)

;(make-sum 'a 6 7)
;(+ a 6 7)

(define (sum? x)
  (and (pair? x)
       (eq? (car x) '+)))

(define (addend s)
  (cadr s))

(define (augend s)
  (let ((tail-operand (cddr s)))
    (if (single-operand? tail-operand)
        (car tail-operand)
        (apply make-sum tail-operand))))

(define test-sum-1 '(+ 1 2 ))
(define test-sum-2 '(+ 1 2 3))
(define test-sum-3 '(+ 1 2 3 4))
(define test-sum-4 '(+ 1 2 a))
(define test-sum-5 '(+ 1 2 3 a))

(augend test-sum-1) ; 2
(augend test-sum-2) ; 5
(augend test-sum-3) ; (+ 2 3 4)
(augend test-sum-4) ; (+ 2 a)
(augend test-sum-5) ; (+ 2 3 a)

(define (make-product m1 . m2)
  (if (single-operand? m2)
      (let ((m2 (car m2)))
        (cond ((or (=number? m1 0) (=number? m2 0))
               0)
              ((=number? m1 1)
               m2)
              ((=number? m2 1)
               m1)
              ((and (number? m1) (number? m2))
               (* m1 m2))
              (else
               (list '* m1 m2))))
      (cons '* (cons m1 m2))))

(define (product? x)
  (and (pair? x)
       (eq? (car x) '*)))

(define (multiplier p)
  (cadr p))

(define (multiplicand p)
  (let ((tail-operand (cddr p)))
    (if (single-operand? tail-operand)
        (car tail-operand)
        (apply make-product tail-operand))))

(make-product 6 7) ; 42
(make-product 6 7 8) ; (* 6 7 8)

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

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

(deriv '(+ x 3) 'x)
; 1

(deriv '(* x y) 'x)
; y

(deriv '(* (* x y) (+ x 3)) 'x)
; (+ (* x y) (* y (+ x 3)))

(deriv '(* x y (+ x 3)) 'x)
; (+ (* x y) (* y (+ x 3)))