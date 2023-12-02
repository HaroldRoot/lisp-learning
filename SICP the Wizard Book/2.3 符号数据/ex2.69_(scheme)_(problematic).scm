(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_representing_huffman_trees.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_sets_of_weighted_elements.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_the_decoding_procedure.scm")

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

#|--------------------------------------------------------------------------------|#

#||
ex2.70_(problematic)_rock_n_roll.rkt 出错了，得出的答案和网上的不一致，
现在在排查从哪里开始出问题了。
||#

(generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))
;Value: ((leaf a 4) ((leaf b 2) ((leaf c 1) (leaf d 1) (c d) 2) (b c d) 4) (a b c d) 8)

#||
huangz1990 的 SICP 解题集里的输出是
;Value: ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)
我的 d 和 c 的顺序和他不一样，但是它们权重都是 1，应该无所谓？
||#

#|--------------------------------------------------------------------------------|#

(generate-huffman-tree '((A 1) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1)))
#||
((leaf na 16) ((leaf yip 9) ((leaf sha 3) ((leaf get 2) ((leaf job 2) ((leaf a 1) ((leaf boom 1) (leaf wah 1) 
(boom wah) 2) (a boom wah) 3) (job a boom wah) 5) (get job a boom wah) 7) (sha get job a boom wah) 10) (yip sha get job a boom wah) 19) (na yip sha get job a boom wah) 35)
向左的全都是叶子

schemewiki 上的：
((leaf na 16) ((leaf yip 9) (((leaf a 2) ((leaf wah 1) (leaf boom 1) (wah boom) 2) (a wah boom) 4) ((leaf sha 3) ((leaf job 2) (leaf get 2) 
(job get) 4) (sha job get) 7) (a wah boom sha job get) 11) (yip a wah boom sha job get) 20) (na yip a wah boom sha job get) 36)
向左的可以是树

我应该是没搞懂 111-112 页的归并
我的生成 Huffman 树算法有问题
||#