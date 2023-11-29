(define x (list 1 3 (list 5 7) 9))

x
;Value: (1 3 (5 7) 9)

(car (cdr (car (cdr (cdr x)))))
;Value: 7

(car (cdaddr x))
;Value: 7

#|------------------------------------|#

(define y (list (list 7)))

y
;Value: ((7))

(car (car y))
;Value: 7

(caar y)
;Value: 7

#|------------------------------------|#

(define z (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

z
;Value: (1 (2 (3 (4 (5 (6 7))))))

(cdr z)
;Value: ((2 (3 (4 (5 (6 7))))))

(cadadr z)
;Value: (3 (4 (5 (6 7))))

(cadadr (cadadr z))
;Value: (5 (6 7))

(cadadr (cadadr (cadadr z)))
;Value: 7

#|------------------------------------|#

;;; ex1.43_repeated.scm

(define (repeated procedure times)
    (lambda (parameter)
            (iter procedure times parameter)))

(define (iter f step result)
        (if (= step 0)
            result
            (iter f (- step 1) (f result))))

((repeated cadadr 3) z)
;Value: 7