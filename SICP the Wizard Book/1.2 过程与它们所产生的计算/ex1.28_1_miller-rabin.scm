;;;; Miller-Rabin 检查

#||
费马小定理的一个变形。
如果 n 是素数，
a 是任何小于 n 的整数，
则 a 的 (n-1) 次幂与 1 模 n 同余。

我在 eg1.2.6_fermat_test.scm 的注释里说，
这是费马小定理更加常用的一种形式：
a^{p-1} mod p = 1
||#

(define (prime? n)
    (loop miller-rabin n (- n 1)))

(define (loop procedure parameter times)
    (cond ((= times 1) true)
          ((procedure parameter times) (loop procedure parameter (- times 1)))
          (else false)))

(define (miller-rabin n a)
    (= (expmod a (- n 1) n ) 1))

(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((even? exp) 
           (remainder (square (expmod base (/ exp 2) m)) m)) 
          (else  
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

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

;;; 全 #f
;;; Miller-Rabin 检查不会受骗