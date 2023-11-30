#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; how-to-combine: 如何组合分裂前的原图和分裂后的图
;; how-to-split: 如何组合分裂后的两个小图
(define (split how-to-combine how-to-split)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split how-to-combine how-to-split) painter (- n 1))))
          (how-to-combine painter (how-to-split smaller smaller))))))

(define right-split (split beside below))

(define up-split (split below beside))

(paint (right-split einstein 4))

(paint (up-split einstein 4))