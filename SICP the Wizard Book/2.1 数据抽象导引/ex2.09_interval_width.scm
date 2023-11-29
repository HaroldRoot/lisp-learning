(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

#|----------------------------------------------------------|#

(define (width-of-interval x)
    (/ (- (upper-bound x) (lower-bound x)) 2))

;;; 测试

(define test (make-interval 3.65 3.35))

(define another (make-interval 6.7 7.6))

(width-of-interval test)
;Value: .1499999999999999

(width-of-interval another)
;Value: .44999999999999973

#|----------------------------------------------------------|#

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y))))

(define (print-interval x)
    (newline)
    (display (lower-bound x))
    (display ", ")
    (display (upper-bound x)))

(define sum (add-interval test another))

(define diff (sub-interval test another))

(print-interval sum)
; 10.05, 11.25
; 上下界差 1.2
; 宽 0.6

(print-interval diff)
; -4.25, -3.0500000000000003
; 上下界差 1.2
; 宽 0.6

(width-of-interval sum)
;Value: .5999999999999996

(+ (width-of-interval test) (width-of-interval another))
;Value: .5999999999999996

(width-of-interval diff)
;Value: .5999999999999999

(- (width-of-interval test) (width-of-interval another))
;Value: -.2999999999999998

#|----------------------------------------------------------|#

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))

(define (div-interval x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))

(define product (mul-interval test another))

(define quotient (div-interval test another))

(print-interval product)
; 22.445, 27.74

(print-interval quotient)
; .4407894736842105, .544776119402985

(width-of-interval product)
;Value: 2.647499999999999

(* (width-of-interval test) (width-of-interval another))
;Value: .06749999999999992

(width-of-interval quotient)
;Value: 5.1993322859387237e-2

(/ (width-of-interval test) (width-of-interval another))
;Value: .3333333333333333