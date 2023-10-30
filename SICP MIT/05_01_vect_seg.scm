;;; using vectors

(define (+vect v1 v2)
    (make-vector 
        (+ (xcor v1) (xcor v2))
        (+ (ycor v1) (ycor v2))))

(define (scale s v)
    (make-vector (* s (xcor v))
                 (* s (ycor v))))

;;; representing vectors

(define make-vector cons)
(define xcor car)
(define ycor cdr)

;;; representing line segments

(define make-seg cons)
(define seg-start car)
(define seg-end cdr)

;;; test

(make-seg (make-vector 2 3)
          (make-vector 5 1))
;; ((2 . 3) 5 . 1)