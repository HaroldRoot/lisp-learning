(define compose 
    (lambda (f g) 
        (lambda (x) (f (g x)))))

(define inc 1+)

((compose square inc) 6)
;Value: 49