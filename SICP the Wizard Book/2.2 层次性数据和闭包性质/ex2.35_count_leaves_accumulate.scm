;;; eg2.2.3_signal_flow.scm
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

;;; eg2.2.2_count_leaves.scm
(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1) ; Scheme 提供了基本过程 pair?
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

(define x (cons (list 1 2) (list 3 4)))

(count-leaves x)
;Value: 4

#|-------------------------------------------------------|#

(define (enumerate-tree tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (list tree))
          (else (append (enumerate-tree (car tree))
                        (enumerate-tree (cdr tree))))))

(define (new-count-leaves t)
    (accumulate +
                0
                (map (lambda (x) 1) (enumerate-tree t))))

(new-count-leaves x)
;Value: 4