(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/eg2.2.4_transform_painter.scm")
; 引入 transform-painter

(define (flip-horiz painter) 
    (transform-painter painter 
                        (make-vect 1.0 0.0) 
                        (make-vect 0.0 0.0) 
                        (make-vect 1.0 1.0))) 

(define (rotate180 painter) 
    (transform-painter painter 
                       (make-vect 1.0 1.0) 
                       (make-vect 0.0 1.0) 
                       (make-vect 1.0 0.0))) 

(define (rotate270 painter) 
    (transform-painter painter 
                       (make-vect 0.0 1.0) 
                       (make-vect 0.0 0.0) 
                       (make-vect 1.0 1.0)))

; (define (rotate180 painter) 
;     (rotate90 (rotate90 painter))) 

; (define (rotate270 painter) 
;     (rotate90 (rotate90 (rotate90 painter)))) 