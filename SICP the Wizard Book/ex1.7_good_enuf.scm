#|-----------------旧版--------------------|#

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

(sqrt 2) ; 1.4142156862745097
(square (sqrt 2)) ; 2.0000060073048824

(sqrt 0.0000012345) ; .03126315403643578
(square (sqrt 0.0000012345)) ; 9.773848003059107e-4

(sqrt 9876543210) ; 99380.79900061179
(square (sqrt 9876543210)) ; 9876543210.000002

#|-----------------新版--------------------|#

(define (new-sqrt-iter guess last-guess x)
    (if (new-good-enough? guess last-guess)
        guess
        (new-sqrt-iter (improve guess x)
                   guess
                   x)))

(define (new-good-enough? guess last-guess)
    (< (abs (- guess last-guess)) 0.00001))

(define (new-sqrt x)
    (new-sqrt-iter 1.0 0.0 x))

(new-sqrt 2) ; 1.4142135623746899
(square (new-sqrt 2)) ; 2.0000000000045106

(new-sqrt 0.0000012345) ; 1.1110805827348246e-3
(square (new-sqrt 0.0000012345)) ; 1.2345000613303574e-6

(new-sqrt 9876543210) ; 99380.79900061179
(square (new-sqrt 9876543210)) ; 9876543210.000002