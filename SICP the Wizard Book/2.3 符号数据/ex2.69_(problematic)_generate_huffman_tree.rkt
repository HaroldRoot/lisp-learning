#lang racket

(require racket/include)
(include "eg2.3.4_representing_huffman_trees.scm")
(include "eg2.3.4_sets_of_weighted_elements.scm")
(include "eg2.3.4_the_decoding_procedure.scm")

#|-----------------------------------------------|#

(display "make-leaf-set 将序对表转换为叶的有序集")
(newline)

(define test-pairs
  (list '(B 2) '(A 4) '(C 1) '(D 1)))

(display "序对表：")
test-pairs
; 虽然序对表的顺序是乱的，但 make-leaf-set 会自动排序成升序

; make-leaf-set 过程来自 eg2.3.4_sets_of_weighted_elements.scm
(define test-leaves-1
  (make-leaf-set test-pairs))

(display "叶的有序集：")
test-leaves-1
; '((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4))

(define test-leaves-2
  (reverse test-leaves-1))

(display "叶的有序集，从权重高到权重低：")
test-leaves-2
; '((leaf A 4) (leaf B 2) (leaf C 1) (leaf D 1))

#|-----------------------------------------------|#

(newline)

(display "4叶树：")
(make-code-tree (car test-leaves-2)
                (make-code-tree (cadr test-leaves-2)
                                (make-code-tree (caddr test-leaves-2)
                                                (cadddr test-leaves-2))))

(display "2叶树：")
(make-code-tree (car test-leaves-2) (cadr test-leaves-2))

;(display "1叶树：")
;(make-code-tree (car test-leaves-2) '())
;报错

;(display "0叶树：")
;(make-code-tree '() '())
;报错

(newline)

#|-----------------------------------------------|#

;;; 有头绪了!!!!!!!

(define (successive-merge descending-leaves)
  (define (make-subtree leaves)
    (cond ((null? leaves)
           '())
          ((null? (cdr leaves))
           (car leaves))
          (else
           (make-code-tree (car leaves)
                           (make-subtree (cdr leaves))))))
  (cond ((= 0 (length descending-leaves))
         '())
        ((= 1 (length descending-leaves))
         (list (car descending-leaves)
                 '()
                 (list (symbol-leaf (car descending-leaves)))
                 (weight-leaf (car descending-leaves))))
        (else
         (make-subtree (reverse descending-leaves)))))

(define (generate-huffman-tree pairs)
  (successive-merge 
   (make-leaf-set pairs)))

(generate-huffman-tree test-pairs)

(generate-huffman-tree '())

(generate-huffman-tree (list '(B 2)))