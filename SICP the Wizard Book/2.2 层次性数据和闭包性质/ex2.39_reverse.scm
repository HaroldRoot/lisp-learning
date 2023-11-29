(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define fold-right accumulate)

(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter initial sequence))

(define (reverse-1 sequence)
    (fold-right (lambda (x y) (append y (list x)))
                '()
                sequence))

(define (reverse-2 sequence)
    (fold-left (lambda (x y) (cons y x))
               '()
               sequence))

(define test-seq (list 1 2 3 6 7))

(reverse-1 test-seq)
;Value: (7 6 3 2 1)

(reverse-2 test-seq)
;Value: (7 6 3 2 1)

(define (reverse-3 sequence)
    (fold-left (lambda (x y) (list y x))
               '()
               sequence))

(reverse-3 test-seq)
;Value: (7 (6 (3 (2 (1 ())))))
; 错误示范！

(define (reverse-4 sequence)
    (fold-left (lambda (x y) (append (list y) x))
               '()
               sequence))

(reverse-4 test-seq)
;Value: (7 6 3 2 1)