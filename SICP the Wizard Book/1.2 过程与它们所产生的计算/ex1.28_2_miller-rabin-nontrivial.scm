;;;; Miller-Rabin 检查，书上要求的写法，只用检测 n/2 次

#||
书上说：

Miller-Rabin 检查用法：
随机地取一个数 a<n
并用过程 expmod 求 a^{n-1} mod n

然而，在执行 expmod 中的平方步骤时，
((even? exp) (remainder (square (expmod base (/ exp 2) m)) m)) 
需要查看是否遇到了 “1 取模 n 的非平凡平方根”，
即，是否存在不等于 1 或者 n-1 的数，其平方取模 n 等于 1。

可以证明，如果这种 1 的非平凡平方根存在，那么 n 就不是素数。

还可以证明，如果 n 是非素数的奇数，那么至少有一半的数 a<n，
按照这种方式计算 a^{n-1}，将会遇到 1 取模 n 的非平凡平方根。

我脑子要炸了，这是在说啥啊？？？
||#

(define (prime? n)
    (loop miller-rabin n (ceiling (/ n 2)))) 
;; 因为在计算 a^{n-1} 时只有一半的机率会遇到 “1 取模 n 的非平凡平方根”
;; 所以至少要执行 n/2 次才能保证测试结果准确

(define (loop procedure parameter times)
    (cond ((= times 0) true) 
          ((procedure parameter) (loop procedure parameter (- times 1))) 
          (else false)))

(define (miller-rabin n) 
    (let ((a (+ 1 (random (- n 1))))) 
        (= (expmod a (- n 1) n ) 1)))

(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((nontrivial-square-root? base m) 0) ; 增加对非平凡方根的检测
          ((even? exp) 
            (remainder (square (expmod base (/ exp 2) m)) m))
          (else  
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

(define (nontrivial-square-root? a n) ; 进行非平凡方根检查
    (and (not (= a 1)) ; 查看是否有一个数 a，既不等于 1
         (not (= a (- n 1))) ; 也不等于 n−1
         (= 1 (remainder (square a) n)))) ; 但其平方取模 n 等于 1

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

;;; 素数测试

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