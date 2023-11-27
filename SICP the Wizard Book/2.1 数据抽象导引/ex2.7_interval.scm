;;;; 扩展练习：区间算术

#||
Wishful Thinking

假设有一种称为 “区间” 的抽象对象
这种对象有两个端点，一个上界和一个下界

给定两个端点，就可以用构造函数 make-interval
||#

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

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

#|---------------------------------------------------------|#

(define (make-interval a b) (cons a b))

#|---------------------------------------------------------|#

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

;;; 测试

(define test (make-interval 3.65 3.35))

(lower-bound test)
;Value: 3.35

(upper-bound test)
;Value: 3.65

(define another (make-interval 6.7 7.6))

(define (print-interval x)
    (newline)
    (display (lower-bound x))
    (display ", ")
    (display (upper-bound x)))

(print-interval another)
; 6.7, 7.6

(print-interval (add-interval test another))
; 10.05, 11.25

(print-interval (mul-interval test another))
; 22.445, 27.74

(print-interval (div-interval test another))
; .4407894736842105, .544776119402985