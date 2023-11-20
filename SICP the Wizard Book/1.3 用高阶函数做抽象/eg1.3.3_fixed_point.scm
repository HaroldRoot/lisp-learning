;;;; 找出函数的不动点

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

(fixed-point cos 1.0)
; .7390822985224024

;;; 找出方程 y = sin y + cos y 的一个解
(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)
; 1.2587315962971173

#||
(define (sqrt x)
    (fixed-point (lambda (y) (/ x y))
                 1.0))

(sqrt 2)

这一不动点搜寻并不收敛
在答案的两边往复振荡
||#

(define (average x y)
    (/ (+ x y) 2.0))

(define (sqrt x)
    (fixed-point (lambda (y) (average y (/ x y)))
                 1.0))

(sqrt 2)
; 1.4142135623746899