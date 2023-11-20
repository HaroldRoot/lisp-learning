(define (f g)
    (g 2))

(f square) ; 4

(f (lambda (z) (* z (+ z 1)))) ; 6

#||
试想，如果坚持要求解释器去求值 (f f)：
假设可以使用代换模型
(f f) -> (f 2) -> (2 2)
||#

; (f f)
; The object 2 is not applicable.