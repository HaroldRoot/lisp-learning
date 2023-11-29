(cons (list 1 2) (list 3 4))
;Value: ((1 2) 3 4)

(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1) ; Scheme 提供了基本过程 pair?
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

(define x (cons (list 1 2) (list 3 4)))

(length x)
;Value: 3
; (1 2)
; 3
; 4

(count-leaves x)
;Value: 4

(list x x)
;Value: (((1 2) 3 4) ((1 2) 3 4))

(length (list x x))
;Value: 2
; ((1 2) 3 4)
; ((1 2) 3 4)

(count-leaves (list x x))
;Value: 8