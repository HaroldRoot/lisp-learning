#|| 原程序：

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)(= (remainder b a) 0))
||#

#|| 不足之处：

在检查一个数是否能被 2 整除后，
没必要再检查它能否被之后的任何偶数整除了。
迭代器的自增方式，应该改为：跳到下一个奇数。
即，把 (+ test-divisor 1) 改成 (next-odd test-divisor)
||#

(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next-odd test-divisor)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n) (= (smallest-divisor n) n))

(define (next-odd n) (if (odd? n) (+ 2 n) (+ 1 n)))

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

(define (timed-prime-test n)
    (newline)
    (display "起点为 ")
    (display n)
    (display "，开始寻找素数……")
    (newline)
    (start-prime-test n (real-time-clock)))

(define (start-prime-test n start-time)
    (if (search-for-primes n 3)
        (report-prime (- (real-time-clock) start-time))))

(define (report-prime elapsed-time)
    (display "总计用时：")
    (display elapsed-time))

#|-------------------------------------------------|#

(timed-prime-test 1000)
#||
(timed-prime-test 1000)
起点为 1000，开始寻找素数……
1009 is a prime.
1013 is a prime.
1019 is a prime.
Search complete.
总计用时：0
||#

(timed-prime-test 10000)
#||
(timed-prime-test 10000)
起点为 10000，开始寻找素数……
10007 is a prime.
10009 is a prime.
10037 is a prime.
Search complete.
总计用时：0
||#

(timed-prime-test 100000)
#||
起点为 100000，开始寻找素数……
100003 is a prime.
100019 is a prime.
100043 is a prime.
Search complete.
总计用时：0
||#

(timed-prime-test 1000000)
#||
起点为 1000000，开始寻找素数……
1000003 is a prime.
1000033 is a prime.
1000037 is a prime.
Search complete.
总计用时：1
||#
