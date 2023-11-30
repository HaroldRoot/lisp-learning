(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/eg2.2.4_transform_painter.scm")
; 引入 transform-painter，beside

(define (below painter1 painter2) ; 1 below 2，1 在 2 的下面
    (let ((split-point (make-vect 0.0 0.5)))
        (let ((paint-bottom
                (transform-painter painter1
                                   split-point
                                   (make-vect 1.0 0.5)
                                   (make-vect 0.0 0.0)))
              (paint-top
                (transform-painter painter2
                                   (make-vect 0.0 0.0)
                                   (make-vect 1.0 0.0)
                                   split-point)))
             (lambda (frame)
                (paint-top frame)
                (paint-bottom frame)))))


(define (below-2 painter1 painter2) 
    (rotate90 (beside (rotate270 painter1) (rotate270 painter2)))) ; 在草稿纸上画出来就好懂了