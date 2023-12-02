#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)
  (drop-duplicates (append set1 set2) '()))

(define (drop-duplicates objects stack)
  (if (null? objects)
      (reverse stack)
      (let ((current-object (car objects))
            (remaining-objects (cdr objects)))
            (if (element-of-set? current-object stack)
                (drop-duplicates remaining-objects stack)
                (drop-duplicates remaining-objects
                                 (cons current-object stack))))))

(union-set '(1 2 3) '(0 3 6 7))
; (1 2 3 0 6 7)

(union-set '(6 7) '())
; (6 7)