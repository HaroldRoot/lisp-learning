;;; Rational number arithmetic

(define (+rat x y) ; 有理数加法
    (make-rat 
        (+ (* (numer x) (denom y))
           (* (numer y) (denom x)))
        (* (denom x) (denom y))))

(define (-rat x y) ; 有理数减法
    (make-rat 
        (- (* (numer x) (denom y))
           (* (numer y) (denom x)))
        (* (denom x) (denom y))))

(define (*rat x y) ; 有理数乘法
    (make-rat 
        (* (numer x) (numer y))
        (* (denom x) (denom y))))

(define (/rat x y) ; 有理数乘法
    (make-rat 
        (* (numer x) (denom y))
        (* (denom x) (numer y))))

;;; Installing rational numbers in the
;;; generic arithmetic system

(define (make-rat x y)
    (attach-type 'rational (cons x y)))

(put 'rational 'add +rat)
(put 'rational 'sub -rat)
(put 'rational 'mul /rat)
(put 'rational 'div /rat)

(define (operate-2 op arg1 arg2)
    (if (eq? (type arg1) (type arg2))
        (let ((proc (get (type arg1) op)))
            (if (not (null? proc))
                (proc (contents arg1)
                      (contents arg2))
                (error
                    "Op undifined on type")))
        (error "Args not same type")))

;;; Installing complex numbers

(define (make-complex z)
    (attach-type 'complex z))

(define (+complex z1 z2)
    (make-complex (+c z1 z2)))

(put 'complex 'add +complex)

;;; similarly for -complex *complex /complex

;;; Installing ordinary numbers

(define (make-number n)
    (attach-type 'complex n))

(define (+number x y)
    (make-number (+ x y)))

(put 'number 'add +number)

;;; similarly for -number *number /number

;;; Installing polynomials

(define (make-polynomials var term-list)
    (attach-type 'polynomial
        (cons var term-list)))

(define (+poly p1 p2)
    (if (same-var? (var p1) (var p2))
        (make-polynomial
            (var p1)
            (+terms (term-list p1)
                    (term-list p2)))
        (error "Polys not in same var")))

(put 'polynomial 'add +poly)

(define (+terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
            (let ((t1 (first-term L1))
                  (t2 (first-term L2)))
                (cond 
                    ((> (order t1) (order t2))
                        (adjoin-term 
                            t1 
                            (+terms (rest-terms L1) L2)))
                    ((< (order t1) (order t2))
                        (adjoin-term
                            t2
                            (+terms L1 (rest-terms L2))))
                    (else 
                        (adjoin-term
                            (make-term (order t1)
                                       (ADD (coeff t1) ; 特别注意这个ADD！
                                            (coeff t2)))
                            (+terms (rest-terms L1)
                                    (rest-terms L2)))))))))