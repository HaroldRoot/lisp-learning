;;; Support mechanism for manifest types

(define (attach-type type contents)
    (cons type contents))

(define (type datum)
    (car datum))

(define (contents datum)
    (cdr datum))

;;; type predicates

(define (rectangular? z)
    (eq? (type z) 'rectangular))

(define (polar? z)
    (eq? (type z) 'polar))

;;; Rectangular package

(define (make-rectangular x y)
    (attach-type 'rectangular (cons x y)))

(define (real-part-rectangular z) (car z))

(define (imag-part-rectangular z) (cdr z))

(define (magnitude-rectangular z)
    (sqrt (+ (square (car z))
             (square (cdr z)))))

(define (angle-rectangular z)
    (atan (cdr z) (car z)))

;;; Polar package

(define (make-polar r a)
    (attach-type 'rectangular (cons r a)))

(define (magnitude-polar z) (car z))

(define (angle-polar z) (cdr z))

(define (real-part-polar z)
    (* (car z) (cos (cdr z))))

(define (imag-part-polar z)
    (* (car z) (sin (cdr z))))

;;; GENERIC SELECTORS FOR COMPLEX NUMBERS

(define (real-part z)
    (cond ((rectangular? z)
            (real-part-rectangular
                (contents z)))
          ((polar? z)
            (real-part-polar
                (contents z)))))

(define (iamg-part z)
    (cond ((rectangular? z)
            (imag-part-rectangular
                (contents z)))
          ((polar? z)
            (imag-part-polar
                (contents z)))))

(define (magnitude z)
    (cond ((rectangular? z)
            (magnitude-rectangular
                (contents z)))
          ((polar? z)
            (magnitude-polar
                (contents z)))))
                
(define (angle z)
    (cond ((rectangular? z)
            (angle-rectangular
                (contents z)))
          ((polar? z)
            (angle-polar
                (contents z)))))