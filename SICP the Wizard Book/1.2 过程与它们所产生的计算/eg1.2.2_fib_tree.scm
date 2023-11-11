(define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1))
                   (fib (- n 2))))))

(fib 5) ; 5

(fib 6) ; 8

#|-------------------------------------|#

(define (sqrt-iter guess x)
    (if (good-enough? guess x) 
        guess
        (sqrt-iter (improve guess x)
                   x)))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))

(define phi 1.6180)

(/ (* phi phi phi phi phi) (sqrt 5)) ; 4.959151841207932

(/ (* phi phi phi phi phi phi) (sqrt 5)) ; 8.023907679074435