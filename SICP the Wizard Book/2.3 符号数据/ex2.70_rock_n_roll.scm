(load "SICP the Wizard Book/2.3 符号数据/ex2.69_generate_huffman_tree.scm")

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

test-huffman-tree
#||
((leaf na 16) ((leaf yip 9) 
(((leaf a 2) ((leaf wah 1) (leaf boom 1) (wah boom) 2) (a wah boom) 4) 
((leaf sha 3) ((leaf job 2) (leaf get 2) (job get) 4) (sha job get) 7) 
(a wah boom sha job get) 11) (yip a wah boom sha job get) 20) 
(na yip a wah boom sha job get) 36)
这次对了
||#


(define test-message
  '(Get a job
    Sha na na na na na na na na
    Get a job
    Sha na na na na na na na na
    Wah yip yip yip yip 
    yip yip yip yip yip
    Sha boom))

test-message
;Value: (get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom)
; 自动变成小写了呢……现在用的是 VS Code MIT/GNU Scheme Release 11.2

;;; 发现之前的 encode 过程写得也是有问题的，不能处理左分支是树不是叶的情况，现在重新写了
(load "SICP the Wizard Book/2.3 符号数据/ex2.68_encode.scm")

(define encoded-message
  (encode test-message test-huffman-tree))

(display "编码后的消息：")
encoded-message

(display "编码后的消息长度：")
(length encoded-message)
;Value: 84
; 终于对了