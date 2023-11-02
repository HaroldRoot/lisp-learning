;;; Installing the rectangular
;;; operations in the table

(put 'rectangular 'real-part
    real-part-rectangular)

(put 'rectangular 'imag-part
    imag-part-rectangular)

(put 'rectangular 'magnitude
    magnitude-rectangular)

(put 'rectangular 'angle
    angle-rectangular)

;;; Installing the polar
;;; operations in the table

(put 'polar 'real-part
    real-part-polar)

(put 'polar 'imag-part
    imag-part-polar)

(put 'polar 'magnitude
    magnitude-polar)

(put 'polar 'angle
    angle-polar)

;;; 代替经理

(define (operate op obj)
    (let ((proc (get (type obj) op)))
        (if (not (null? proc))
            (proc (contents obj))
            (error "undefined OP"))))

;;; Defining the selectors using operate

(define (real-part obj)
    (operate 'real-part obj))

(define (iamg-part obj)
    (operate 'imag-part obj))

(define (magnitude obj)
    (operate 'magnitude obj))

(define (angle obj)
    (operate 'angle obj))