(define (expmod base exp m) 
    (cond ((= exp 0) 1) 
          ((even? exp) 
           (remainder (square (expmod base (/ exp 2) m)) m)) 
          (else  
            (remainder (* base (expmod base (- exp 1) m)) m)))) 

#|---------------------------------------------------------------------------|#

#||
(define (fermat-test n a)
    (= (expmod a n n ) a))

(define (prime? n)
    (loop fermat-test n (- n 1)))

(define (loop procedure parameter times)
    (cond ((= times 1) true)
          ((procedure parameter times) (procedure parameter (- times 1)))
          (else false)))
||#

#|---------------------------------------------------------------------------|#

#||
(define (random-fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)) 
    (try-it (+ 1 (random (- n 1))))) 

(define (fast-prime? n times)
    (cond ((= times 0) true) 
          ((random-fermat-test n) (fast-prime? n (- times 1)))
          (else false))) 
||#

#|---------------------------------------------------------------------------|#

(define (prime? n choose-algorithm)
    (cond ((eq? choose-algorithm 'foreach) (loop foreach-fermat-test n (- n 1) 1))
          ((eq? choose-algorithm 'random) (loop random-fermat-test n 100 0))
          (else "Please choose a valid algorithm!")))

(define (loop procedure parameter now end)
    (cond ((= now end) true)
          ((procedure parameter now) (loop procedure parameter (- now 1) end))
          (else false)))

(define (foreach-fermat-test n a)
    (fermat-test n a))

(define (random-fermat-test n redundant-parameter)
    (fermat-test n (+ 1 (random (- n 1)))))
; random 过程接受一个整数参数n，并返回一个小于 n 的非负整数
; (random (- n 1)) 返回一个小于 n-1 的非负整数，即范围 [0, n-2]
; (+ 1 (random (- n 1))) 即范围 [1, n-1]

(define (fermat-test n a)
    (= (expmod a n n ) a))

#|---------------------------------------------------------------------------|#

;;; 测试：合数、质数、费马伪素数、Carmicheal 数

(prime? 711 'foreach) ;Value: #f
(prime? 769 'foreach) ;Value: #t
(prime? 645 'foreach) ;Value: #f
(prime? 561 'foreach) ;Value: #t

(prime? 711 'random) ;Value: #f
(prime? 769 'random) ;Value: #t
(prime? 645 'random) ;Value: #f
(prime? 561 'random) ;Value: #t

(prime? 561 'somethingelse) ;Value: "Please choose a valid algorithm!"