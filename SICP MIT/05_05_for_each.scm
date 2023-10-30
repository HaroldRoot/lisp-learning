(define (for-each proc list)
    (cond ((null? list) "done")
          (else (proc (car list))
                (for-each proc (cdr list)))))