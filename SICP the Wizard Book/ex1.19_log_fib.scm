#||
eg1.2.2_fib_iter.scm

(define (fib n)
    (fib-iter 1 0 n))

(define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))

定义 T 变换：a <- a+b 和 b <- a
从 1 和 0 开始将 T 反复应用 n 次
将产生出一对 Fib(n+1) 和 Fib(n)
（滑块、滑动！）

定义 T_pq 变换：
a <- bq + aq + ap
b <- bp + aq

现在将 T 看作是变换族 T_pq 中
p=0 且 q=1 的特殊情况，即
a <- b1 + a1 + a0 <- a + b
b <- b0 + a1 <- a

可以证明，如果对 (a,b) 应用变换 T_pq 两次，
其效果等同于应用同样形式的一次变换 T_p'q'，
其中的 p' 和 q' 可以由 p 和 q 计算出来

根据我的计算，
p' = p^2 + q^2
q' = q^2 + 2*p*q
||#

(define (fib n)
    (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (fib-iter a
                     b 
                     (+ (* p p) (* q q))
                     (+ (* q q) (* 2 p q))
                     (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))

(fib 5) ; 5
(fib 6) ; 8
(fib 7) ; 13
(fib 8) ; 21
(fib 9) ; 34
(fib 10) ; 55