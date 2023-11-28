(map + (list 1 2 3) (list 40 50 60) (list 700 800 900))
;Value: (741 852 963)

(map + (list 1 2 3 4) (list 40 50 60) (list 700 800 900))
;Value: (741 852 963)

(map + (list 1 2) (list 40 50 60) (list 700 800 900))
;Value: (741 852)

(map + (list 1 2 3) (list 40) (list 700 800))
;Value: (741)

#|-------------------------------------------------------------|#

(map (lambda (x y) (+ x (* 2 y)))
     (list 1 2 3)
     (list 4 5 6))
;Value: (9 12 15)

; (map (lambda (x y) (+ x (* 2 y)))
;      (list 1 2 3)
;      (list 4 5 6)
;      (list 7 8 9))
; The procedure #[compound-procedure 12] has been called with 3 arguments; 
; it requires exactly 2 arguments.

(map (lambda (x y) (+ x (* 2 y)))
     (list 1 2 3 4)
     (list 4 5 6))
;Value: (9 12 15)

#|-------------------------------------------------------------|#

(define (scale-list items factor)
    (if (null? items)
        '()
        (cons (* (car items) factor)
              (scale-list (cdr items) factor))))

(scale-list (list 1 2 3 4 5) 10)
;Value: (10 20 30 40 50)

(define (my-map proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (my-map proc (cdr items)))))

(my-map abs (list -10 2.5 -11.6 17))
;Value: (10 2.5 11.6 17)

(my-map (lambda (x) (* x x))
        (list 1 2 3 4))
;Value: (1 4 9 16)

(define (new-scale-list items factor)
    (my-map (lambda (x) (* x factor))
            items))

(new-scale-list (list 1 2 3 4 5) 10)
;Value: (10 20 30 40 50)