(define one-through-four (list 1 2 3 4))

one-through-four
;Value: (1 2 3 4)

(car one-through-four)
;Value: 1

(cdr one-through-four)
;Value: (2 3 4)

(car (cdr one-through-four))
;Value: 2

(cons 10 one-through-four)
;Value: (10 1 2 3 4)

(cons 5 one-through-four)
;Value: (5 1 2 3 4)

(define (list-ref items n)
    (if (= n 0)
        (car items)
        (list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))

(list-ref squares 3)
;Value: 16

(define (length items)
    (if (null? items) ; 内置类型 null?
        0
        (+ 1 (length (cdr items)))))

(define odds (list 1 3 5 7))

(length odds)
;Value: 4

(define (len items)
    (define (len-iter a count)
        (if (null? a)
            count
            (len-iter (cdr a) (+ 1 count))))
    (len-iter items 0))

(length squares)
;Value: 5

(append squares odds) ; 内置 append
;Value: (1 4 9 16 25 1 3 5 7)

(append odds squares)
;Value: (1 3 5 7 1 4 9 16 25)

(define (my-append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2)))) 

(my-append odds odds)
;Value: (1 3 5 7 1 3 5 7)