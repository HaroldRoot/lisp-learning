;;;; 检查 Carmicheal 数

#||
其实我在学费马检查的时候，
就已经测试过一些费马伪素数了。
eg1.2.6_fermat_test.scm
但是有些能被检测出来是素数？

书上第 35 页，注释，
Carmicheal 数中最小的几个是
561，1105，1729，2465，2821，6601

其中 561，1105 确实没被检测出来！
||#

(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((even? exp) 
           (remainder (square (expmod base (/ exp 2) m)) m)) 
          (else  
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

(define (fermat-test n a)
    (= (expmod a n n ) a)) ; 如果 a^n%n=a，说明 n 有可能是一个素数，否则就一定不是

(define (prime? n)
    (loop fermat-test n (- n 1)))

(define (loop procedure parameter times)
    (cond ((= times 1) true)
          ((procedure parameter times) (loop procedure parameter (- times 1)))
          (else false)))

#|------------------------------------------------------------------------------|#

;;; 合数测试

(prime? 4)
(prime? 9)
(prime? 15)

(prime? 711)
(prime? 899)
(prime? 987)

;;; 全 #f

#|------------------------------------------------------------------------------|#

;;; 质数测试

(prime? 2)
(prime? 3)
(prime? 5)

(prime? 769)
(prime? 877)
(prime? 983)

;;; 全 #t

#|------------------------------------------------------------------------------|#

;;; 费马伪素数测试

(prime? 341)
(prime? 645)
(prime? 1387)

(prime? 34945)
(prime? 35333)
(prime? 39865)

;;; 全 #f

#|------------------------------------------------------------------------------|#

;;; Carmicheal 数

(prime? 561)
(prime? 1105)
(prime? 1729)
(prime? 2465)
(prime? 2821)
(prime? 6601)

;;; 全 #t
;;; a^n%n=a 的方法检测不出它们其实是合数