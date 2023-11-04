;;;; Imperative version
;;;; 命令式版本
(define (fact n)
    (let ((i 1) (m 1))
        (define (loop)
            (cond ((> i n) m)
                  (else 
                    (set! m (* i m))
                    (set! i (+ i 1))
                    (loop))))
        (loop)))

(fact 5) ; 120