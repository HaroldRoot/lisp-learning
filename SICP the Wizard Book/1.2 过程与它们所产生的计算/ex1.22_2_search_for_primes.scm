;;;; 对练习 1.22 的正式实践

;;; 寻找最小因子的过程
;;; eg1.2.6_smallest_divisor.scm
;;; 具有 O(√n) 的增长阶

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond 
          ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
    (= (remainder b a) 0))

#|-------------------------------------------------|#

;;; 判断素数的过程

(define (prime? n)
    (= (smallest-divisor n) n))

#|-------------------------------------------------|#

;;; 生成奇数的过程

(define (next-odd n)
    (if (odd? n) (+ 2 n) (+ 1 n)))

;;; 检查给定范围内连续的各个奇数的素性
;;; “给定范围”这个说法可能不太准确？
;;; 我认为应该是：从“给定起点”开始找到 3 个素数为止
;;; 找出大于 1 000、大于 10 000、大于 100 000 和大于 1 000 000 的三个最小的素数

(define (search-for-primes n goal)
    (cond ((= goal 0) 
            (display "Search complete.")
            (newline)
            true)
          ((prime? n) 
            (display n)
            (display " is a prime.")
            (newline)
            (search-for-primes (next-odd n) (- goal 1)))
          (else
            (search-for-primes (next-odd n) goal))))

#|-------------------------------------------------|#

;;; 计算检查所用时间的过程

(define (timed-prime-test n)
    (newline)
    (display "起点为 ")
    (display n)
    (display "，开始寻找素数……")
    (newline)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (search-for-primes n 3)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display "总计用时：")
    (display elapsed-time))

#|-------------------------------------------------|#

;;; 测试

(timed-prime-test 1000)
#||
起点为 1000，开始寻找素数……
1009 is a prime.
1013 is a prime.
1019 is a prime.
Search complete.
总计用时：0.
||#

(timed-prime-test 10000)
#||
起点为 10000，开始寻找素数……
10007 is a prime.
10009 is a prime.
10037 is a prime.
Search complete.
总计用时：0.
||#

(timed-prime-test 100000)
#||
起点为 100000，开始寻找素数……
100003 is a prime.
100019 is a prime.
100043 is a prime.
Search complete.
总计用时：0.
||#

(timed-prime-test 1000000)
#||
起点为 1000000，开始寻找素数……
1000003 is a prime.
1000033 is a prime.
1000037 is a prime.
Search complete.
总计用时：0.
||#