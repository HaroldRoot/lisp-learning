(define (sum-of-largest-two x y z)
  (cond ((and (>= x y) (>= y z)) (+ x y)) 
        ((and (>= x z) (>= z y)) (+ x z)) 
        (else (+ y z))))

(sum-of-largest-two 1 2 3) ; 5

(sum-of-largest-two 2 2 3) ; 5

(sum-of-largest-two 2 2 2) ; 4