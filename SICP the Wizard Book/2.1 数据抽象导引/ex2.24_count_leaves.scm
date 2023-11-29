(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1) ; Scheme 提供了基本过程 pair?
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

(define x (list 1 (list 2 (list 3 4))))

x
;Value: (1 (2 (3 4)))

(length x)
;Value: 2
; 1
; (2 (3 4))

(count-leaves x)
;Value: 4