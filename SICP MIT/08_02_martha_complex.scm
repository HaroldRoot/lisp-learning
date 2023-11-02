#||
SELECTORS
(REAL-PART Z)
(IMAG-PART Z)
(MAGNITUDE Z)
(ANGLE Z)

CONSTRUCTORS
(MAKE-RECTANGULAR X Y)
(MAKE-POLAR R A)
||#

(define (+c z1 z2)
    (make-rectangular
        (+ (real-part z1) (real-part z2))
        (+ (imag-part z1) (imag-part z2))))

(define (-c z1 z2)
    (make-rectangular
        (- (real-part z1) (real-part z2))
        (- (imag-part z1) (imag-part z2))))

(define (*c z1 z2)
    (make-polar 
        (* (magnitude z1) (magnitude z2))
        (+ (angle z1) (angle z2))))

(define (/c z1 z2)
    (make-polar 
        (/ (magnitude z2) (magnitude z2))
        (- (angle z1) (angle z2))))

;;; Representing complex numbers as
;;; pairs MAGNITUDE, ANGLE

(define (make-polar r a)
    (cons r a))

(define (magnitude z) (car z))

(define (angle z) (cdr z))

(define (make-rectangular x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))

(define (real-part z)
    (* (car z) (cos (cdr z))))

(define (imag-part z)
    (* (car z) (sin (cdr z))))