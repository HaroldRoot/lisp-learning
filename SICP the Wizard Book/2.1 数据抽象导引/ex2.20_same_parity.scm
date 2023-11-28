;;;; 采用一种 带点尾部记法 形式的 define

(define (same-parity first . rest)
    (let ((valid? (if (even? first) even? odd?)))
        (define (iter my-list what-is-left)
            (cond ((null? what-is-left) my-list)
                ((valid? (car what-is-left))
                    (iter (append my-list (list (car what-is-left)))
                        (cdr what-is-left)))
                (else (iter my-list (cdr what-is-left)))))
        (iter (list first) rest)))

(same-parity 1 2 3 4 5 6 7)
;Value: (1 3 5 7)

(same-parity 2 3 4 5 6 7)
;Value: (2 4 6)

(define s-p (lambda (first . rest)
    (let ((valid? (if (even? first) even? odd?)))
        (define (iter my-list what-is-left)
            (cond ((null? what-is-left) my-list)
                ((valid? (car what-is-left))
                    (iter (append my-list (list (car what-is-left)))
                        (cdr what-is-left)))
                (else (iter my-list (cdr what-is-left)))))
        (iter (list first) rest))))

(s-p  1 2 2 3 4 5 6 6 7 8 9 9)
;Value: (1 3 5 7 9 9)