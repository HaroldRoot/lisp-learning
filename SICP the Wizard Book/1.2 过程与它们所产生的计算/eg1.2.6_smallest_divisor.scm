;;;; 检查整数 n 是否为素数的方法之一
;;;; 寻找因子
;;;; O(√n)的增长阶

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ;; 如果 test-divisor 的平方已经超过 n，就没必要继续找了
          ((> (square test-divisor) n) n)
          ;; 如果 test-divisor 能整除 n，那就是它了
          ((divides? test-divisor n) test-divisor)
          ;; 不然 test-divisor 就自增 1 继续找
          (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
    (= (remainder b a) 0))