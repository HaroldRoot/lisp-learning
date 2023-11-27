(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

(define (print-interval x)
    (newline)
    (display (lower-bound x))
    (display ", ")
    (display (upper-bound x)))

#|----------------------------------------------------------|#

(define (sub-interval x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y))))

;;; 测试

(define test (make-interval 3.65 3.35))

(define another (make-interval 6.7 7.6))

(print-interval (sub-interval test another))
; -4.25, -3.0500000000000003