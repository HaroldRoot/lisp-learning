(for-each (lambda (x) (newline) (display x))
    (list 57 321 88))
; 57
; 321
; 88
; ;Unspecified return value

(define (for-each-impl proc items)
    (if (null? items)
        #t
        (begin (proc (car items))
               (for-each-impl proc (cdr items)))))

(for-each-impl (lambda (x) (newline) (display x))
    (list 67 667 6667))
; 67
; 667
; 6667
; ;Value: #t