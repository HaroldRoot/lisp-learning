;;;; 抽象和第一级过程

#||
平方根计算的两种方法
    1. 搜寻不动点
    2. 使用牛顿法（本身表述的也是一个不动点的计算过程）
实际上，每种方法都是
从一个函数出发，
找到这一函数在某种变换下的不动点。
||#

(define (fixed-point-of-transform g transform guess)
    (fixed-point (transform g) guess))

#|---------------------------------------------------|#

;;; 重塑本节的第一个平方根计算
;;; 搜寻 y -> x/y 在平均阻尼下的不动点

(define (sqrt1 x)
    (fixed-point-of-transform (lambda (y) (/ x y))
                              average-damp
                              1.0))

#|---------------------------------------------------|#

;;; 重塑本节的第一个平方根计算
;;; 搜寻 y -> x/y 在平均阻尼下的不动点

(define (sqrt2 x)
    (fixed-point-of-transform (lambda (y) (- (square y) x))
                              newton-transform
                              1.0))

#|---------------------------------------------------|#

;;; 其他细节实现

(define (average x y)
    (/ (+ x y) 2.0))

(define (average-damp f)
    (lambda (x) (average x (f x))))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
           dx)))

(define dx 0.00001)

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

#|---------------------------------------------------|#

;;; 测试

(sqrt1 2)
;Value: 1.4142135623746899

(sqrt2 2)
;Value: 1.4142135623822438