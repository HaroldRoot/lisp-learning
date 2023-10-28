(define (move n from to spare)
    (cond ((= n 0) "done")
        (else
            (move (-1+ n) from spare to)
            (print-move from to)
            (move (-1+ n) spare to from))))

(define (print-move a b)
    (display "\n")
    (display a)
    (display " ")
    (display b)
    )

(move 4 1 2 3)