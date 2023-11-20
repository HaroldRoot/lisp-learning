;;;; 通过区间折半寻找方程的根

(define (search f neg-point pos-point)
    (let ((midpoint (average neg-point pos-point)))
        (if (close-enough? neg-point pos-point)
            midpoint
            (let ((test-value (f midpoint)))
                (cond ((positive? test-value)
                       (search f neg-point midpoint))
                      ((negative? test-value)
                       (search f midpoint pos-point))
                      (else midpoint))))))

(define (close-enough? x y)
    (< (abs (- x y)) 0.001))

(define (average x y) ; 没有内置的 average 过程诶，要自己写
    (/ (+ x y) 2.0))

;;; 特判：这一函数在两个给定点的值，不能同号

(define (half-interval-method f a b)
    (let ((a-value (f a))
          (b-value (f b)))
        (cond ((and (negative? a-value) (positive? b-value))
               (search f a b))
              ((and (negative? b-value) (positive? a-value))
               (search f b a))
              (else
                (error "Values are not of opposite sign" a b)))))

(half-interval-method sin 2.0 4.0)
; 3.14111328125

(half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
                      1.0
                      2.0)
; 1.89306640625