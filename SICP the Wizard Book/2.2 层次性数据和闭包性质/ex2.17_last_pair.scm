;;; ex1.43_repeated.scm
(define (repeated procedure times)
    (lambda (parameter)
            (iter procedure times parameter)))
(define (iter f step result)
        (if (= step 0)
            result
            (iter f (- step 1) (f result))))

(define test (list 23 72 149 34))

(length test)
;Value: 4

((repeated cdr (-1+ (length test))) test)
;Value: (34)

(define last-pair
    (lambda (items)
        ((repeated cdr (-1+ (length items))) items)))

(last-pair test)
;Value: (34)

(define test-2 (list 1 (list 6 7)))

test-2
;Value: (1 (6 7))

(last-pair test-2)
;Value: ((6 7))