#||
b^n = (b^{n/2})^2   若 n 是偶数
b^n = b*b^{n-1}     若 n 是奇数
(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))
(define (even? n) (= (remainder n 2) 0))
||#

(define (iter-expt b n)
    (define (iter a b n)
        (cond ((= n 0) a)
              ((even? n) (iter a (square b) (/ n 2)))
              (else (iter (* a b) b (- n 1)))))
    (iter 1 b n))

(iter-expt 2 10) ; 1024
#||
iter(a,b,n)
iter(1,2,10)
even? 10 YES
iter(1,4,5)
even? 5 NO
iter(4,4,4)
even? 4 YES
iter(4,16,2)
even? 2 YES
iter(4,256,1)
even? 1 NO
(iter 1024,256,0)
n=0 返回 a=1024

由此可见，在迭代过程中，在n减少至0之前，
a始终保证满足a*(b^n)的值不变，
n每减少1，a就乘以b补上。
||#