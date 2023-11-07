;;; 假定我们的语言只有加法而没有乘法

;;; double：求出一个整数的两倍
(define (double a)
    (+ a a))

;;; halve：将一个（偶数）除以2
(define (halve a)
    (/ a 2))

;;; 设计一个类似 fast-expt 的求乘积过程
;;; 使之只用对数的计算步数

#||
(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))
||#

(define (mul a b)
    (cond ((= b 0) 0)
          ((even? b) (double (mul a (halve b))))
          ((odd? b) (+ a (mul a (- b 1))))))

(mul 6 7) ; 42