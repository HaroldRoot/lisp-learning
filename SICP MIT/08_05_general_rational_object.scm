(define (+rat x y)
    (make-rat 
        (ADD (MUL (numer x) (denom y)
             (MUL (denom x) (numer y)))
        (MUL (denom x) (denom y)))))