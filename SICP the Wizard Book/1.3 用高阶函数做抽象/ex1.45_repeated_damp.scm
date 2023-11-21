;;;; 反复做平均阻尼

#||
计算平方根，找 y -> x/y 的不动点，不收敛，这个缺陷可以通过平均阻尼的方式弥补
计算立方根，找 y -> x/y^2 的不动点，同样可以通过平均阻尼
计算四次方根，找 y -> x/y^3 的不动点，一次平均阻尼不够，需要两次
    即 y -> x/y^3 的平均阻尼的平均阻尼
    搜寻才能收敛
||#

#|-----------------------------------------------------------------|#

(define (average x y)
    (/ (+ x y) 2.0))

(define (average-damp f)
    (lambda (x) (average x (f x))))

#|-----------------------------------------------------------------|#

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

#|-----------------------------------------------------------------|#

;;; 练习 1.43 的 repeated 过程

(define compose 
    (lambda (f g) 
        (lambda (x) (f (g x)))))

(define (repeated procedure times)
    (lambda (parameter)
            (iter procedure times parameter)))

(define (iter f step result)
        (if (= step 0)
            result
            (iter f (- step 1) (f result))))

#|-----------------------------------------------------------------|#

(define (expt base exp)
    (cond ((= exp 0) 1)
          ((even? exp)
           (square (expt base (/ exp 2))))
          (else
           (* base (expt base (- exp 1)))))) 

(define (nth-root x n)
    (if (= n 2)
        (fixed-point (average-damp (lambda (y) (/ x y)))
                     1.0)
        (fixed-point ((repeated average-damp (- n 2)) (lambda (y) (/ x (expt y (- n 1))))) 
                     1.0)))

(nth-root 2 2)
;Value: 1.4142135623746899

(nth-root 2 3)
;Value: 1.259923236422975

(nth-root 2 4)
;Value: 1.189207115002721

(nth-root 2 5)
;Value: 1.1486952511198778
