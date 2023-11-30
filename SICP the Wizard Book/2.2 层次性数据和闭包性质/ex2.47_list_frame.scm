(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/ex2.46_rect.scm")

(define (frame-coord-map frame)
    (lambda (v)
        (add-vect
            (origin-frame frame)
            (add-vect (scale-vect (xcor-vect v)
                                  (edge1-frame frame))
                      (scale-vect (ycor-vect v)
                                  (edge2-frame frame))))))

(define (make-frame origin edge1 edge2)
    (list origin edge1 edge2))

(define (origin-frame frame)
    (car frame))

(define (edge1-frame frame)
    (cadr frame))

(define (edge2-frame frame)
    (caddr frame))

;;; 测试

(define o (make-vect 0 0))

(define e1 (make-vect 1 0))

(define e2 (make-vect 0 1))

(define f (make-frame o e1 e2))

f 
;Value: ((0 . 0) (1 . 0) (0 . 1))

(origin-frame f)
;Value: (0 . 0)

(edge1-frame f)
;Value: (1 . 0)

(edge2-frame f)
;Value: (0 . 1)