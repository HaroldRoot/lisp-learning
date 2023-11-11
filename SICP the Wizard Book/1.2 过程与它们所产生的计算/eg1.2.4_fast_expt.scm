;;;; 快速幂

#||
b^n = (b^{n/2})^2   若 n 是偶数
b^n = b*b^{n-1}     若 n 是奇数
||#

(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (begin (newline)
                            (display "调用 (square (fast-expt b (/ n 2)))")
                            (square (fast-expt b (/ n 2)))))
          (else (begin (newline)
                       (display "调用 (* b (fast-expt b (- n 1)))")
                       (* b (fast-expt b (- n 1)))))))

(define (even? n)
    (= (remainder n 2) 0))

(fast-expt 2 1000)
#||
调用 (square (fast-expt b (/ n 2)))
调用 (square (fast-expt b (/ n 2)))
调用 (square (fast-expt b (/ n 2)))
调用 (* b (fast-expt b (- n 1)))
调用 (square (fast-expt b (/ n 2)))
调用 (square (fast-expt b (/ n 2)))
调用 (* b (fast-expt b (- n 1)))
调用 (square (fast-expt b (/ n 2)))
调用 (* b (fast-expt b (- n 1)))
调用 (square (fast-expt b (/ n 2)))
调用 (* b (fast-expt b (- n 1)))
调用 (square (fast-expt b (/ n 2)))
调用 (* b (fast-expt b (- n 1)))
调用 (square (fast-expt b (/ n 2)))
调用 (* b (fast-expt b (- n 1)))
;Value: 10715086071862673209484250490600018105614048117055336074437503883703510511249361224931983788156958581275946729175531468251871452856923140435984577574698574803934567774824230985421074605062371141877954182153046474983581941267398767559165543946077062914571196477686542167660429831652624386837205668069376
调用了 15 次乘法（最后一次是乘以 1）
log_2(1000) = 9.966...
书上注释说，所需乘法次数等于n的以2为底的对数值，再加上n的二进制表示中的1的个数减1
所需乘法次数=9.966...+count1(1111101000)-1=10+6-1=15次！！！
||#