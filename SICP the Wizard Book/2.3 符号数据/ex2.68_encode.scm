(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_representing_huffman_trees.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_sets_of_weighted_elements.scm")
(load "SICP the Wizard Book/2.3 符号数据/eg2.3.4_the_decoding_procedure.scm")

(define (encode-symbol symbol tree)
    (cond ((leaf? tree)
           '())
          ((symbol-in-tree? symbol (left-branch tree))
           (cons 0 (encode-symbol symbol (left-branch tree))))
          ((symbol-in-tree? symbol (right-branch tree))
           (cons 1 (encode-symbol symbol (right-branch tree))))
          (else
           (error "bad symbol: ENCODE-SYMBOL" symbol))))

(define (symbol-in-tree? given-symbol tree)
    (not (false? (find (lambda (s)
                               (eq? s given-symbol))
                       (symbols tree))))) ; 取出 tree 中的所有 symbol

(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))

;;; 测试
(define sample-tree
        (make-code-tree (make-leaf 'A 4)
                        (make-code-tree
                            (make-leaf 'B 2)
                            (make-code-tree (make-leaf 'D 1)
                                            (make-leaf 'C 1)))))

(encode (list 'A 'D 'A 'B 'B 'C 'A) sample-tree)
;Value: (0 1 1 0 0 1 0 1 0 1 1 1 0)

#||
MIT/GNU Scheme Reference Manual
for release 12.1
2022-11-1

149 页
Chapter 7: List
7.6 Searching Lists

(find predicate list)
[SRFI 1 procedure]
Returns the first element in list for which predicate is true; returns #f if it doesn’t
find such an element. Predicate must be a procedure of one argument.
返回 list 中谓词为真的第一个元素；如果找不到，则返回 #f。谓词必须是接收一个参数的过程。
(find even? ’(3 1 4 1 5 9)) => 4
Note that find has an ambiguity in its lookup semantics—if find returns #f, you
cannot tell (in general) if it found a #f element that satisfied predicate, or if it did not
find any element at all. In many situations, this ambiguity cannot arise—either the
list being searched is known not to contain any #f elements, or the list is guaranteed
to have an element satisfying predicate. However, in cases where this ambiguity can
arise, you should use find-tail instead of find—find-tail has no such ambiguity:
注意，`find`在查找语义上存在一个模糊性——如果`find`返回`#f`，
你通常无法判断它是找到了一个满足谓词的`#f`元素，还是根本没有找到任何元素。
在许多情况下，这种模糊性不会出现——要么被搜索的列表已知不包含任何`#f`元素，
要么列表保证有一个满足谓词的元素。然而，在可能出现这种模糊性的情况下，
你应该使用`find-tail`而不是`find`——`find-tail`没有这种模糊性：
(cond ((find-tail pred lis)
        => (lambda (pair) ...)) ; Handle (CAR PAIR)
      (else ...)) ; Search failed.
||#