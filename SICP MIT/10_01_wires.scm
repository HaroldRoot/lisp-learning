;;; Primitives and Means of Combination

(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define d (make-wire))
(define e (make-wire))
(define s (make-wire))

(or-gate a b d)     ; 或门
(and-gate a b c)    ; 与门
(inverter c e)      ; 非门
(and-gate d e s)    ; 与门

;;; Means of Abstraction

(define (half-adder a b s c) ; sum, carry
    (let ((d (make-wire)) (c (make-wire)))
        (or-gate a b d)
        (and-gate a b c)
        (inverter c e)
        (and-gate d e s)))

(define (full-adder a b c-in sum c-out)
    (let ((s (make-wire))
          (c1 (make-wire))
          (c2 (make-wire)))
        (half-adder b c-in s c1)
        (half-adder a s sum c2)
        (or-gate c1 c2 c-out)))

;;; Implementing a Primative

;;; qwq 抄代码意义不大……专心听课吧~