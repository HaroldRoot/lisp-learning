#lang sicp

(define (union-set set1 set2)
  (cond ((and (null? set1) (null? set2))
         '())
        ((null? set1)
         set2)
        ((null? set2)
         set1)
        (else
         (let ((a (car set1))
               (b (car set2)))
           (cond ((= a b)
                  (cons a (union-set (cdr set1) (cdr set2))))
                 ((< a b)
                  (cons a (union-set (cdr set1) set2)))
                 ((> a b)
                  (cons b (union-set set1 (cdr set2)))))))))

(union-set '() (list 1 2 3)) ; (1 2 3)

(union-set (list 1 2 3) '()) ; (1 2 3)

(union-set (list 1 2 3) (list 1 2 3)) ; (1 2 3)

(union-set (list 1 2 3 6 7) (list 1 2 3)) ; (1 2 3 6 7)

(union-set (list 1 2 3) (list 6 7)) ; (1 2 3 6 7)