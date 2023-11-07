;;;; 费马小定理 Fermat's little theorem

#||
假如 a 是一个整数，p 是一个质数，
那么 a^p - a 是 p 的倍数，
可以表示为 a^p mod p = a
例如：
a=2, p=7, 2^7-2=128-2=126 是 7 的 18 倍；
a=3, p=5, 3^5=243, 243 除以 5 等于 48 余 3

如果 a 不是 p 的倍数，
这个定理也可以写成更加常用的一种形式：
a^{p-1} mod p = 1
例如：
a=3, p=5, 3^4=81, 81 除以 5 等于 9 余 1

书上表示为 a^p mod p = a mod p

检查素数的算法：
对于给定的整数 n，
随机任取一个 a<n 并计算 a^n mod n，
如果得到的结果不等于 a，那么 n 肯定不是素数。
如果它就是 a，那么 n 是素数的机会就很大。
再另取一个随机的 a 并用同样方式检查，
如果还满足 a^p mod p = a mod p，
那么我们就能对 n 是素数有更大的信心了！
||#

;;; 计算一个数的幂对另一个数取模的结果
;;; 使用了一种叫做“重复平方取模”的技巧
;;; 可以在指数很大的情况下快速计算出结果
(define (expmod base exp m) ; 计算 base^exp mod m 的值
    (cond ((= exp 0) 1) ; 如果 exp=0，则返回 1
          ((even? exp) ; 如果 exp 是偶数
           ; 则将 base^{exp/2} mod m 的平方对 m 取模
           (remainder (square (expmod base (/ exp 2) m)) m)) 
           (else  ; 如果 exp 是奇数
            ; 则将 base^{exp-1} mod m 与 base 的乘积对 m 取模
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

;;; 对一个正整数 n 进行费马小定理的测试
(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)) ; 如果 a^n%n=a，说明 n 有可能是一个素数，否则就一定不是
    (try-it (+ 1 (random (- n 1))))) ; 使用 random 来生成一个 [1, n-1] 之间的随机数

;;; 对一个正整数 n 进行多次费马小定理的测试
(define (fast-prime? n times)
    (cond ((= times 0) true) ; 如果 n 通过了 times 次费马小定理的测试，那么就认为它是一个素数
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false))) ; 否则就不是

;;; 下面选取几个素数来玩玩
(fast-prime? 599 100) ; #t
(fast-prime? 677 100) ; #t
(fast-prime? 743 100) ; #t
(fast-prime? 859 100) ; #t
(fast-prime? 971 100) ; #t

;;; 下面选取几个合数来玩玩
(fast-prime? 703 100) ; #f
(fast-prime? 813 100) ; #f
(fast-prime? 993 100) ; #f

;;; 试试费马伪素数（它们其实是合数）
(fast-prime? 341 100) ; #f
(fast-prime? 561 100) ; #t 判断错误
(fast-prime? 645 100) ; #f
(fast-prime? 1105 100) ; #t 判断错误
(fast-prime? 1387 100) ; #f
(fast-prime? 33153 100) ; #f
(fast-prime? 34945 100) ; #f
(fast-prime? 35333 100) ; #f
(fast-prime? 39865 100) ; #f
(fast-prime? 41041 100) ; #t 判断错误

#||
如果数 n 不能通过费马检查（#f），
我们可以确信它一定不是素数！
但通过了（#t）也不保证它就是素数。
||#