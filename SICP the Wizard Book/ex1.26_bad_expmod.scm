#||
ex1.24_fermat_timed_test.scm
如果 expmod 过程中使用显式的乘法，
而不是调用 square，
就会把 O(log n) 的计算过程
变成 O(n) 的。
||#

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

(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((even? exp) 
           (remainder (* (expmod base (/ exp 2) m) ; 修改这里
                         (expmod base (/ exp 2) m))
                      m)) 
          (else  
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

#||
(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((even? exp) 
           (remainder (square (expmod base (/ exp 2) m))
                      m)) 
          (else  
            (remainder (* base (expmod base (- exp 1) m)) m))))
||#

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)) 
    (try-it (+ 1 (random (- n 1))))) 

(define (fast-prime? n times)
    (cond ((= times 0) true) 
          ((fermat-test n) (fast-prime? n (- times 1))) 
          (else false))) 

#|-----------------------------------------------------------------|#

(timed-prime-test 1000)
#||
起点为 1000，开始寻找素数……
1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1105, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, Search complete.
总计用时：7573
||#

#||
哇哦……直接从原来的 57 变成 7573，
耗时是原来的 132.86 倍！
素数是一个个蹦出来的。
||#