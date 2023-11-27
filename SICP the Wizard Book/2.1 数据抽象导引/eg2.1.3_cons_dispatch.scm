(define (cons x y)
    (define (dispatch m)
        (cond ((= m 0) x)
              ((= m 1) y)
              (else (error "Argument not 0 or 1 -- CONS" m))))
    dispatch)

(define (car z) (z 0))

(define (cdr z) (z 1))

;;; 测试

(define test (cons 6 7))

test
;Value: #[compound-procedure 12 dispatch]

(car test)
;Value: 6

(cdr test)
;Value: 7

; (2 test)
;The object 2 is not applicable.

(test 2)
;Argument not 0 or 1 -- CONS 2

#||
/SICP MIT/04_05_what_is_pair.scm

(define (cons a b)
    (lambda (pick)
        (cond ((= pick 1) a)
              ((= pick 2) b))))

(define (car x) (x 1))

(define (cdr x) (x 2))
||#