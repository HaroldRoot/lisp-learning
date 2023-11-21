; (define ((compose f g) x)
;     (f (g x)))

(define compose 
    (lambda (f g) 
        (lambda (x) (f (g x)))))

(define (repeated procedure times)
    (lambda (parameter)
            (iter procedure times parameter)))

(define (iter f step result)
        (if (= step 0)
            result
            (iter f (- step 1) (f result))))

#|------------------------------------------------|#

;;; 测试

((repeated square 2) 5)
;Value: 625

((repeated (lambda (x) (+ x 1)) 6) 7)
;Value: 13