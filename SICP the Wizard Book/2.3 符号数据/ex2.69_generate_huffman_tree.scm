(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_representing_huffman_trees.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_sets_of_weighted_elements.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_the_decoding_procedure.scm")

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-set)
    (cond ((= 0 (length ordered-set))
            '())
          ((= 1 (length ordered-set))
            (car ordered-set))
          (else
            (let ((new-sub-tree (make-code-tree (car ordered-set)
                                                (cadr ordered-set)))
                  (remained-ordered-set (cddr ordered-set)))
                (successive-merge (adjoin-set new-sub-tree remained-ordered-set))))))

#||
这个才体现了 111-112 页对归并的描述，
找出两个具有最低权重的叶，也就是 (car ordered-set) 和 (cadr ordered-set)，
然后归并它们，产生出一个以这两个结点为左右分支的结点，
这一步就是 (make-code-tree (car ordered-set) (cadr ordered-set))，
删除这两个结点，剩下的结点 (cddr ordered-set) 视为 remained-ordered-set，
并用新的结点 new-sub-tree 代替它们。
随后继续这一过程 (successive-merge (adjoin-set new-sub-tree remained-ordered-set))
||#

(define test-pairs
  (list '(B 2) '(A 4) '(C 1) '(D 1)))

(generate-huffman-tree test-pairs)
;Value: ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8

(generate-huffman-tree '())
;Value: ()

(generate-huffman-tree (list '(B 2)))
;Value: (leaf b 2)