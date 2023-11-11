(define (a-plus-abs-b a b)
    ((if (> b 0) + -) a b))
; 对 consequent 和 alternative 求值，返回的都是过程

(a-plus-abs-b 7 60) ; 67

(a-plus-abs-b 60 -7) ; 67