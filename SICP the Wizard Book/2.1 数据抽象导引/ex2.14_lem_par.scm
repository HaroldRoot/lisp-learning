(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
    (let ((w (* c (/ p 100.0))))
        (make-center-width c w)))

(define (percent x)
    (let ((c (/ (+ (upper-bound x) (lower-bound x)) 2.0))
          (w (/ (- (upper-bound x) (lower-bound x)) 2.0)))
        (* (/ w c) 100)))

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

;;; 题目设定

(define (par1 r1 r2)
    (div-interval (mul-interval r1 r2)
                  (add-interval r1 r2)))

(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval one
                      (add-interval (div-interval one r1)
                                    (div-interval one r2)))))

#|---------------------------------------------------------|#

;;; 初步测试

(define test-r1 (make-center-percent 60000 0.01))

(define test-r2 (make-center-percent 70000 0.01))

(par1 test-r1 test-r2)
;Value: (32298.001292178473 . 32317.38590782155)

(par2 test-r1 test-r2)
;Value: (32304.461538461535 . 32310.923076923078)

#|---------------------------------------------------------|#

;;; 中心点和百分数误差值测试

(center (par1 test-r1 test-r2))
;Value: 32307.693600000013

(center (par2 test-r1 test-r2))
;Value: 32307.692307692305

(percent (par1 test-r1 test-r2))
;Value: 2.9999999200000554e-2

(percent (par2 test-r1 test-r2))
;Value: 1.0000000000006497e-2

#|---------------------------------------------------------|#

;;; 求 A/A 和 A/B 的值

(div-interval test-r1 test-r1)
;Value: (.9998000199980003 . 1.0002000200020003)

(center (div-interval test-r1 test-r1))
;Value: 1.0000000200000003

(percent (div-interval test-r1 test-r1))
;Value: 1.9999999799998922e-2

(div-interval test-r1 test-r2)
;Value: (.8569714457125716 . .8573143028588573)

(center (div-interval test-r1 test-r2))
;Value: .8571428742857145

(percent (div-interval test-r1 test-r2))
;Value: 1.9999999800004473e-2

;; A/A != 1