(define (+rat x y) ; 有理数加法
    (cons (+ (* (car x) (cdr y))
             (* (car y) (cdr x)))
          (* (cdr x) (cdr y))))


(define a (cons 1 2))

(define b (cons 1 4))

(define ans (+rat a b))

(car ans) ; 6

(cdr ans) ; 8