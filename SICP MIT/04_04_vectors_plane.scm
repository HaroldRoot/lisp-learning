; representing vectors in the plane

(define (make-vector x y) (cons x y)) ; 构造函数

(define (xcor p) (car p)) ; 选择函数

(define (ycor p) (cdr p)) ; 选择函数

; representing line segments

(define (make-seg p q) (cons p q))

(define (seg-start s) (car s))

(define (seg-end s) (cdr s))

(define (midpoint s)
    (let ((a (seg-start s))
          (b (seg-end s)))
        (make-vector
            (average (xcor a) (xcor b))
            (average (ycor a) (ycor b)))))

(define (length s)
    (let
        ((dx (- (xcor (seg-end s))
                (xcor (seg-start s))))
         (dy (- (ycor (seg-end s))
                (ycor (seg-start s)))))
        (sqrt (+ (square dx)
                 (square dy)))))