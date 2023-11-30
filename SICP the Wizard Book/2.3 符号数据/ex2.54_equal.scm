(define (equal? a b)
    (cond ((and (symbol? a) (symbol? b))
           (eq? a b))
          ((and (number? a) (number? b))
           (= a b))
          ((or (and (number? a) (symbol? b))
               (and (symbol? a) (number? b)))
           #f)
          (else (equal-list? a b))))

(define (equal-list? a b)
    (cond ((and (null? a) (null? b)) #t)
          ((or (null? a) (null? b)) #f)
          (else (and (eq? (car a) (car b))
                     (equal-list? (cdr a) (cdr b))))))

(equal? 'x 'y)
;Value: #f

(equal? 'abc 'abc)
;Value: #t

(equal? 6 7)
;Value: #f

(equal? 6 6)
;Value: #t

(equal? 6 'y)
;Value: #f

(equal? 'x 7)
;Value: #f

(equal? '(this is a list) '(this is a list))
;Value: #t

(equal? '(this is a list) '(this (is a) list))
;Value: #f