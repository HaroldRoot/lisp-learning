#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;;;; 注释 91
;;; 不使用 rotate180
;;; 使用 ex1.42_compose.scm 中的 compose 过程

(define compose 
    (lambda (f g) 
        (lambda (x) (f (g x)))))

(define (square-of-four tl tr bl br) ; 左上,右上,左下,右下
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (square-limit painter n)
  ((square-of-four flip-horiz
                   identity
                   (compose flip-vert flip-horiz)
                   flip-vert)
   (corner-split painter n)))

;;; 测试

(paint einstein)

(paint (rotate180 einstein))

(paint (flip-horiz einstein))

(paint (flip-vert einstein))

(paint ((compose flip-vert flip-horiz) einstein))

;;; 引入之前的

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

;;; 测试

(paint (square-limit einstein 4))