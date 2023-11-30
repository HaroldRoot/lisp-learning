#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(paint einstein)

(define einstein2 (beside einstein (flip-vert einstein)))

(paint einstein2)

(define einstein4 (below einstein2 einstein2 ))

(paint einstein4)

;;; 抽象出典型的 painter 组合模式
;;; 以便将这种组合操作实现为一些 Scheme 过程
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define new-einstein4 (flipped-pairs einstein))

(paint new-einstein4)