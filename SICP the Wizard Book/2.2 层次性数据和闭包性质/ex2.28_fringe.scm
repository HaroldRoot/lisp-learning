;;;; 过程 fringe
;;;; lambda (一个树) 所有树叶
;;;; 参数和返回值均用表来表示

(define x (list (list 1 2) (list 3 4)))

x
;Value: ((1 2) (3 4))

#||
;;; ex2.24_count_leaves.scm

(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1) ; Scheme 提供了基本过程 pair?
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

(define x (list 1 (list 2 (list 3 4))))

(count-leaves x)
;Value: 4
||#

(define (fringe x)
    (cond ((not (pair? x)) (list x))
          (else (cond ((and (not (null? (car x)))
                            (not (null? (cdr x))))
                       (append (fringe (car x)) (fringe (cdr x))))
                      ((and (not (null? (car x)))
                            (null? (cdr x)))
                       (fringe (car x)))
                      ((and (null? (car x))
                            (not (null? (cdr x))))
                       (fringe (cdr x)))))))

(fringe x)
;Value: (1 2 3 4)

(fringe (list x x))
;Value: (1 2 3 4 1 2 3 4)

#|----------------------------------------------------------------|#

;;; 学到第 78 页的时候，回过头来改进

(define (new-fringe x)
    (cond ((null? x) '())
          ((not (pair? x)) (list x))
          (else (append (new-fringe (car x))
                        (new-fringe (cdr x))))))

(new-fringe x)
;Value: (1 2 3 4)

(new-fringe (list x x x))
;Value: (1 2 3 4 1 2 3 4 1 2 3 4)