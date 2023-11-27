(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

#|-----------------------------------------|#

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2))

#|-----------------------------------------|#

;;; c 是中心点，p 是百分比，w 是区间宽
(define (make-center-percent c p)
    (let ((w (* c (/ p 100.0))))
        (make-center-width c w)))

(define (percent x)
    (let ((c (/ (+ (upper-bound x) (lower-bound x)) 2.0))
          (w (/ (- (upper-bound x) (lower-bound x)) 2.0)))
        (* (/ w c) 100)))

#|-----------------------------------------|#

;;; 测试

(define test (make-center-percent 10 67))

test
;Value: (3.3 . 16.7)

(center test)
;Value: 10.

(width test)
;Value: 6.699999999999999

(percent test)
;Value: 67.