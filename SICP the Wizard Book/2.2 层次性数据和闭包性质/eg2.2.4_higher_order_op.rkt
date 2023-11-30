#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;;;; 高阶操作

;;; 除了可以获得组合 painter 的抽象模式之外
;;; 还可以抽象出 painter 的各种组合操作的模式
;;; 以 painter 操作作为参数，创建出各种新的 painter 操作

(define (square-of-four tl tr bl br) ; 左上，右上，左下，右下
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (flipped-pairs painter)
  (let ((combine4 (square-of-four identity flip-vert
                                  identity flip-vert)))
    (combine4 painter)))

(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz identity
                                  rotate180 flip-vert)))
    (combine4 (corner-split painter n))))

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

(paint (flipped-pairs einstein))

(paint (flipped-pairs (flipped-pairs einstein)))

(paint (square-limit einstein 4))