#lang racket

(require racket/include)
(include "eg2.3.4_representing_huffman_trees.scm")
(include "eg2.3.4_sets_of_weighted_elements.scm")
(include "eg2.3.4_the_decoding_procedure.scm")

#|-----------------------------------------------|#

;;; 练习 2.67：定义编码树和示例消息：

(define sample-tree
  (make-code-tree 
   (make-leaf 'A 4)
   (make-code-tree
    (make-leaf 'B 2)
    (make-code-tree 
     (make-leaf 'D 1)
     (make-leaf 'C 1)))))

(define sample-message 
  '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-tree)
; (A D A B B C A)