;;;; 对牛顿法进行更多尝试

#||
49 页 1.3 节的牛顿法真把我给绕晕了
难道我真的不适合学数学……qwq
||#

;;; 定义寻找一个函数 f(x) 的不动点 x0 的过程

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

;;; 定义求一个函数 g(x) 的导数 g'(x) 的过程

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
           dx)))

(define dx 0.00001)

;;; 定义牛顿转换，把 g(x) 转换成 x - g(x)/g'(x)

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

;;; 定义牛顿法

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

#|-----------------------------------------------|#

;;; 求余弦函数的不动点
;;; cos(x) = x
;;; cos(x) - x = 0
;;; g(x) = cos(x) - x
;;; 正确答案 .7390822985224024

(newtons-method (lambda (x) (- (cos x) x))
                1.0)
;Value: .7390851332151611

;;; 找出方程 x = sin x + cos x 的一个解
;;; sin x + cos x - x = 0
;;; g(x) = sin x + cos x - x
;;; 正确答案 1.2587315962971173

(newtons-method (lambda (x) (- (+ (sin x) (cos x)) x))
                1.0)
;Value: 1.2587281774929726

;;; 求 C 的立方根
;;; x^3 = C
;;; x^3 - C = 0
;;; g(x) = x^3 - C

(define (cube x) (* x x x))

(define (cube-root C)
    (newtons-method (lambda (x) (- (cube x) C))
                    1.0))

(cube-root 67)
;Value: 4.06154810044568

(cube (cube-root 67))
;Value: 67.00000000000003