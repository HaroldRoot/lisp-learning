#lang racket
(require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

; a) 给 ex2.49_segments_to_painter.rkt 的基本 wave 画家加入某些线段
; 例如，加上一个笑脸

(paint
  (segments->painter
    (list
      (make-segment (make-vect 0 0.65) (make-vect 0.14 0.39))
      (make-segment (make-vect 0.14 0.39) (make-vect 0.29 0.58))
      (make-segment (make-vect 0.29 0.58) (make-vect 0.34 0.49))
      (make-segment (make-vect 0.34 0.49) (make-vect 0.24 0))
      (make-segment (make-vect 0.4 0) (make-vect 0.49 0.28))
      (make-segment (make-vect 0.49 0.28) (make-vect 0.59 0))
      (make-segment (make-vect 0.71 0)  (make-vect 0.59 0.45))
      (make-segment (make-vect 0.59 0.45) (make-vect 0.99 0.15))
      (make-segment (make-vect 0.99 0.35) (make-vect 0.74 0.64))
      (make-segment (make-vect 0.74 0.64) (make-vect 0.59 0.64))
      (make-segment (make-vect 0.74 0.64) (make-vect 0.59 0.64))
      (make-segment (make-vect 0.59 0.64) (make-vect 0.64 0.85))
      (make-segment (make-vect 0.64 0.85) (make-vect 0.59 1))
      (make-segment (make-vect 0.39 1) (make-vect 0.34 0.85))
      (make-segment (make-vect 0.34 0.85) (make-vect 0.39 0.64))
      (make-segment (make-vect 0.39 0.64) (make-vect 0.29 0.64))
      (make-segment (make-vect 0.29 0.64) (make-vect 0.14 0.6))
      (make-segment (make-vect 0.14 0.6) (make-vect 0 0.84))
      (make-segment (make-vect 0.44 0.73) (make-vect 0.47 0.7))
      (make-segment (make-vect 0.47 0.7) (make-vect 0.49 0.7))
      (make-segment (make-vect 0.49 0.7) (make-vect 0.51 0.73)))))

; b) 修改 corner-split 的构造模式
; 例如，只用 up-split 和 right-split 的图像各一个副本，而不是两个

(define (split how-to-combine how-to-split)
  (lambda (painter n)
    (if (= n 0)
        (how-to-split painter painter) ; 动了点手脚
        (let ((smaller ((split how-to-combine how-to-split) painter (- n 1))))
          (how-to-combine (how-to-split painter painter) (how-to-split smaller smaller)))))) ; 动了点手脚

(define right-split (split beside below))

(define up-split (split below beside))

(define (corner-split painter n) 
  (if (= n 0) 
      painter 
      (beside (below painter (up-split painter (- n 1))) 
              (below (right-split painter (- n 1)) (corner-split painter (- n 1)))))) 

(paint (corner-split einstein 2))

; c) 修改 square-limit，换一种使用 square-of-four 的方式
; 以另一种不同模式组合起各个角区
; 例如，让大的爱因斯坦从正方形的每个角向内看

(define (square-of-four tl tr bl br) ; 左上,右上,左下,右下
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (square-limit painter n)
    (let ((combine4 (square-of-four identity flip-horiz
                                    flip-vert rotate180)))
        (combine4 (corner-split-2 painter n))))

(define (corner-split-2 painter n) 
  (if (= n 0) 
      painter 
      (beside (below (corner-split painter (- n 1)) (right-split painter (- n 1)))
              (below painter (up-split painter (- n 1))))))

(paint (square-limit einstein 4))