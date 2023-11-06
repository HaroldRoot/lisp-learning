(define (cbrt-iter guess last-guess x)
    (if (good-enough? guess last-guess) 
        guess
        (cbrt-iter (improve guess x)
                   guess
                   x)))

(define (improve guess x)
    (/ (+ (/ x (* guess guess)) (* 2 guess)) 3.0))

(define (good-enough? guess last-guess)
    (< (abs (- guess last-guess)) 0.00001))

(define (cbrt x)
    (cbrt-iter 1.0 0.0 x))

(define (cube x)
    (* x x x))

(cbrt 2) ; 1.2599210498948732
(cube (cbrt 2)) ; 2.

(cbrt 0.0000012345) ; 1.0727463151735164e-2
(cube (cbrt 0.0000012345)) ; 1.234500000052838e-6

(cbrt 9876543210) ; 2145.531965799228
(cube (cbrt 9876543210)) ; 9876543210.000002