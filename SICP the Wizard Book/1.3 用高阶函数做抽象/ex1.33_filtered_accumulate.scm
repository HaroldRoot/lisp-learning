#||
(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a) 
                  (accumulate combiner
                              null-value
                              term
                              (next a)
                              next
                              b))))
||#

(define (filtered-accumulate combiner null-value term a next b valid?) ; 末尾多了一个过滤器 valid?
    (if (> a b)
        null-value
        (let ((rest-terms (filtered-accumulate combiner
                                               null-value
                                               term
                                               (next a)
                                               next
                                               b
                                               valid?)))
            (if (valid? a)
                (combiner (term a) rest-terms)
                rest-terms))))

#|-----------------------------------------------------------------------|#

;;; 求出在区间 [a, b] 中所有素数之和

;;; 前提：已写出谓词 prime?

(define (prime? n)
    (loop miller-rabin n (ceiling (/ n 2)))) 

(define (loop procedure parameter times)
    (cond ((= times 0) true) 
          ((procedure parameter) (loop procedure parameter (- times 1))) 
          (else false)))

(define (miller-rabin n) 
    (let ((a (+ 1 (random (- n 1))))) 
        (= (expmod a (- n 1) n ) 1)))

(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((nontrivial-square-root? base m) 0) 
          ((even? exp) 
            (remainder (square (expmod base (/ exp 2) m)) m))
          (else  
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

(define (nontrivial-square-root? a n) 
    (and (not (= a 1)) 
         (not (= a (- n 1))) 
         (= 1 (remainder (square a) n)))) 

;;; 构建过程

(define identity (lambda (x) x))

(define (sum-primes a b)
    (filtered-accumulate + 0 identity a 1+ b prime?))

(sum-primes 2 10)
#||
;Value: 17
17 = 2 + 3 + 5 + 7
不能写 (sum-primes 1 10)
因为 n=1 时，(random (- n 1)) -> (random 0)
但是 random 函数需要一个正整数作为参数
;The object 0, passed as an argument to random, is not in the correct range.
||#

#|-----------------------------------------------------------------------|#

;;; 小于 n 的所有与 n 互素的正整数（即所有满足 GCD(i,n)=1 的整数 i<n）之乘积

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(define (some-kind-of-product n)
    (define (satisfied? i)
        (= (gcd i n) 1))
    (filtered-accumulate * ; combiner
                         1 ; null-value
                         identity ; term
                         1 ; a
                         1+ ; next
                         (- n 1) ; b
                         satisfied?)) ; filter / valid?

(some-kind-of-product 10)
#||
;Value: 189
=1*3*7*9
||#

#||
由于 gcd 需要 2 个参数 i 和 n，
所以 satisfied? 需要 2 个参数，
但是过滤器应该只接受 1 个参数，也就是当前项，
所以 satisfied? 只好写在块结构里了。
||#