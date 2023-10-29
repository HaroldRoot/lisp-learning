(define (sum term a next b) 
    (if (> a b)
        0
        (+ (term a)
            (sum term (next a) next b))))

(define (sum-int a b)
    (define (identity x) x) ; <term> 必须是过程
    (sum identity a 1+ b))

(define (sum-sq a b)
    (sum square a 1+ b))

(define (pi-sum a b)
    (sum (lambda (i) (/ i (* i (+ i 2)))) 
        a
        (lambda (i) (+ i 4))
        b))
