#||
在写 expmod 时，我们做了过多的额外工作？

eg1.2.6_fermat_test.scm

(define (expmod base exp m)
    (cond ((= exp 0) 1) 
          ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m)) 
          (else (remainder (* base (expmod base (- exp 1) m)) m)))) 

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)) 
    (try-it (+ 1 (random (- n 1))))) 

(define (fast-prime? n times)
    (cond ((= times 0) true) 
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false))) 
||#

#||
毕竟已经知道怎样计算乘幂？

eg1.2.4_fast_expt.scm

(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (begin (newline)
                            (display "调用 (square (fast-expt b (/ n 2)))")
                            (square (fast-expt b (/ n 2)))))
          (else (begin (newline)
                       (display "调用 (* b (fast-expt b (- n 1)))")
                       (* b (fast-expt b (- n 1)))))))

因此只需要简单地像下面这样写：
||#

(define (expmod base exp m)
    (remainder (fast-expt base exp) m))

(define (fast-expt base exp)
    (cond ((= exp 0) 1)
          ((even? exp) (square (fast-expt base (/ exp 2))))
          (else (* base (fast-expt base (- exp 1))))))

#||
到这一步，据我观察，
这种“新的” expmod 写法，
只是把取模放到了最后的最后一次性完成。
||#

#|----------------------------------------------------------------------|#

;;; 测试准备
;;; ex1.24_fermat_timed_test.scm

(define (next-odd n) (if (odd? n) (+ 2 n) (+ 1 n)))

(define (search-for-primes n goal)
    (cond ((= goal 0) 
            (display "Search complete.")
            (newline)
            true)
          ((fast-prime? n 100)
            (display n)
            (display ", ")
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
    (if (search-for-primes n 50) 
        (report-prime (- (real-time-clock) start-time))))

(define (report-prime elapsed-time)
    (display "总计用时：")
    (display elapsed-time))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)) 
    (try-it (+ 1 (random (- n 1))))) 

(define (fast-prime? n times)
    (cond ((= times 0) true) 
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false))) 

#|----------------------------------------------------------------------|#

;;; 开始测试

(timed-prime-test 1000)
#||
起点为 1000，开始寻找素数……
1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1105, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, Search complete.
总计用时：184
||#

(timed-prime-test 10000)
#||
起点为 10000，开始寻找素数……
10007, 10009, 10037, 10039, 10061, 10067, 10069, 10079, 10091, 10093, 10099, 10103, 10111, 10133, 10139, 10141, 10151, 10159, 10163, 10169, 10177, 10181, 10193, 10211, 10223, 10243, 10247, 10253, 10259, 10267, 10271, 10273, 10289, 10301, 10303, 10313, 10321, 10331, 10333, 10337, 10343, 10357, 10369, 10391, 10399, 10427, 10429, 10433, 10453, 10457, Search complete.
总计用时：14282
||#

#||
(timed-prime-test 100000)
懒得等了，10000的时候还能一个一个蹦出来，
到了100000慢得第一个都迟迟不出来。
||#

#||
使用原版 expmod 的用时：57 -> 75
使用新版 expmod 的用时：184 -> 14282
差距：3.23 倍 -> 190.43 倍
太可怕了qwq
||#