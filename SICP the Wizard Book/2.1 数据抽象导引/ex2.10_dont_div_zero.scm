;;;; 除以一个横跨 0 的区间的意义不清楚

(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))

; (define (div-interval x y)
;     (mul-interval x
;                   (make-interval (/ 1.0 (upper-bound y))
;                                  (/ 1.0 (lower-bound y)))))

(define (div-interval x y)
    (if (okay-to-div? y)
        (mul-interval x
                   (make-interval (/ 1.0 (upper-bound y))
                                  (/ 1.0 (lower-bound y))))
        (error "The meaning of dividing by an interval across 0 is not clear!")))

(define (okay-to-div? x)
    (not (and (<= (lower-bound x) 0)
              (>= (upper-bound x) 0))))

;;; 测试

(define aaa (make-interval 6 7))

(define bbb (make-interval -6 7))

(div-interval aaa aaa)
;Value: (.8571428571428571 . 1.1666666666666665)

(div-interval aaa bbb)
;The meaning of dividing by an interval across 0 is not clear!