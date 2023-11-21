;;;; 采用不同的的初始猜测值 first-guess
;;;; 并展示运行步骤

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                (begin (display next)
                       (display ". Search finished!") 
                       next)
                (begin (display guess)
                       (display ", ")
                       (try next)))))
    (try first-guess))

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
           dx)))

(define dx 0.00001)

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

#|-----------------------------------------------------------|#

;;; 测试寻找根号 2

(newtons-method (lambda (x) (- (square x) 2)) 1.0)
#||
1., 1.4999975000090175, 1.416666805550865, 
1.4142135623822438. Search finished!
||#

(newtons-method (lambda (x) (- (square x) 2)) 100.0)
#||
100., 50.01000251079438, 25.02499976987703, 
12.552462418015985, 6.3558993208309795, 
3.3352861838116907, 1.9674694888135595, 
1.4920030469242287, 1.4162416954704131, 
1.4142135623790075. Search finished!
||#

#|-----------------------------------------------------------|#

#||
ex1.36_display_fixed_point.scm

47 页，练习 1.36，
找出 x^x=1000 的一个根，
这个根是 x -> log(1000)/log(x) 的不动点。
||#

(define (f x)
    (/ (log 1000)
       (log x)))

(define (g x)
    (- (f x) x))

(newtons-method g 1.1)
#||
1.1, 1.2031111365232854, 1.4171505498752162, 
1.8647459684876773, 2.739571005009046, 
3.921085601423088, 4.5047783077309, 
4.555270646545241, 4.555535705195135. 
Search finished!

只用了 8 步，
ex1.36_display_fixed_point.scm 中，
不使用平均阻尼的方法，花了 36 步；
使用平均阻尼的方法，花了 12 步。
||#