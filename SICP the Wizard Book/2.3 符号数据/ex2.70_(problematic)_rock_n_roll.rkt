#lang racket

(require racket/include)
(include "eg2.3.4_representing_huffman_trees.scm")
(include "eg2.3.4_sets_of_weighted_elements.scm")
(include "eg2.3.4_the_decoding_procedure.scm")

;;;; !!!这个程序是有问题的!!!

;;; 练习 2.69
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

;;; 练习 2.68
(define (encode message tree)
  (if (null? message)
      '()
      (append 
       (encode-symbol (car message) 
                      tree)
       (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (define (iter result current-node)
    (cond ((eq? symbol
                (symbol-leaf (left-branch current-node)))
           (reverse (cons 0 result)))
          ((leaf? (right-branch current-node))
           (if (eq? symbol (symbol-leaf (right-branch current-node)))
               (reverse (cons 1 result))
               (error "bad symbol: ITER" symbol)))
          (else (iter (cons 1 result)
                      (right-branch current-node)))))
  (iter '() tree))

;;; 练习 2.70
(define test-pairs
  (list '(A    2)
        '(NA  16)
        '(BOOM 1)
        '(SHA  3)
        '(GET  2)
        '(YIP  9)
        '(JOB  2)
        '(WAH  1)))

(define test-huffman-tree
  (generate-huffman-tree test-pairs))
(display "哈夫曼树：\n")
test-huffman-tree

(define test-message
  '(Get a job
    Sha na na na na na na na na
    Get a job
    Sha na na na na na na na na
    Wah yip yip yip yip 
    yip yip yip yip yip
    Sha boom))

(define (symbol-upcase sym)
  (string->symbol (string-upcase (symbol->string sym))))

(define upcase-message (map symbol-upcase test-message))

; upcase-message

(define encoded-message
  (encode upcase-message test-huffman-tree))

(display "编码后的消息：")
encoded-message

(display "编码后的消息长度：")
(length encoded-message) ; 87

#||
如果采用定长编码，一共 8 个符号，
每个要占用 3 个二进制位，
消息一共 36 个符号,
那么使用定长编码所需的二进制位
为 36 * 3 = 108 。

哈夫曼编码节省了 21 位。

从哪里开始出错了，
网上的答案说
编码后的消息长度应该是 84
节省了 24 位
||#

(decode encoded-message test-huffman-tree)
