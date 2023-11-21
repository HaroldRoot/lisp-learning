;;;; 平均阻尼

(define (average x y)
    (/ (+ x y) 2.0))

(define (average-damp f)
    (lambda (x) (average x (f x))))

((average-damp square) 10)
;Value: 55.
; 返回 10 与 100 的平均值 55

#|------------------------------------|#

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        ;; 计算 f(guess) 的值，并将其赋给 next
        (let ((next (f guess)))
            ;; 如果 guess 和 next 的差的绝对值小于 tolerance，返回 next，否则递归调用 try 函数
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

#|------------------------------------|#

(define (sqrt x)
    (fixed-point (average-damp (lambda (y) (/ x y)))
                 1.0))

(sqrt 2)
;Value: 1.4142135623746899

#|------------------------------------|#

(define (cube-root x)
    (fixed-point (average-damp (lambda (y) (/ x (square y))))
                 1.0))

(define (cube x)
    (* x x x))

(cube-root 67)
;Value: 4.0615497956125495

(cube (cube-root 67))
;Value: 67.00008389133272
