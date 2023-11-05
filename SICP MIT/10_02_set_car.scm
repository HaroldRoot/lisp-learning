(define a (cons 1 2))

(define b (cons a a))

a
; (1 . 2)

b
; ((1 . 2) 1 . 2)

(set-car! (car b) 3)
; Unspecified return value

(car a)
; 3

(cadr b)
; 3

a
; (3 . 2)

b
; ((3 . 2) 3 . 2)