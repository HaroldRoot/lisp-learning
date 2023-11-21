(define inc
    (lambda (parameter) 
            (1+ parameter)))

(inc 1)
;Value: 2

(define double
    (lambda (procedure)
            (lambda (parameter)
                    (procedure (procedure parameter)))))

((double inc) 1)
;Value: 3

(((double (double double)) inc) 5)
;Value: 21