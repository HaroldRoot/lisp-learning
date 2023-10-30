(define (make-rat n d)
    (let ((g (gcd n d)))
        (cons (/ n g)
              (/ d g))))

(define (+rat x y) ; 有理数加法
    (make-rat 
        (+ (* (numer x) (denom y))
            (* (numer y) (denom x)))
        (* (denom x) (denom y))))

(define (*rat x y) ; 有理数乘法
    (make-rat 
        (* (numer x) (numer y))
        (* (denom x) (denom y))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define a (make-rat 1 2))

(define b (make-rat 1 4))

(define ans (+rat a b))

(numer ans) ; 3

(denom ans) ; 4