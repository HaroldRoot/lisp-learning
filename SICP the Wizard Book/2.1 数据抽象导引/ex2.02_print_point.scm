(define make-point cons)

(define x-point car)

(define y-point cdr)

(define make-segment cons)

(define start-segment car)

(define end-segment cdr)

#||
midpoint = ((start.x+end.x)/2, (start.y+end.y)/2)
||#

(define (midpoint-segment seg)
    (make-point (/ (+ (x-point (start-segment seg))
                      (x-point (end-segment seg)))
                   2.0)
                (/ (+ (y-point (start-segment seg))
                      (y-point (end-segment seg)))
                   2.0)))

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))

;;; 测试

(define a (make-point 1 2))

(define b (make-point 6 7))

(print-point a)
; (1,2)

(print-point b)
; (6,7)

(define s (make-segment a b))

(print-point (midpoint-segment s))
; (3.5,4.5)