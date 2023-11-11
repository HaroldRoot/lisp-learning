;;;; 欧几里得算法

#||
如果 r 是 a 除以 b 的余数，
说明 a = kb + r（其中 k 也是一个整数），
如果 c 是 a 和 b 的公约数，
那么 a = xc，b = yc，
那么 xc = kyc + r，
那么 r = (x - ky) c，
那么 c 也是 b 和 r 的公约数！

总结：GCD(a,b)=GCD(b,r)
||#

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
;;; 这将产生一个迭代计算过程，
;;; 其步数依所涉及的数的对数增长。

(gcd 206 40) ; 2