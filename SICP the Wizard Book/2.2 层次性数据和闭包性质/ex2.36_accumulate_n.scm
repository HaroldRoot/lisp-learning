(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/eg2.2.3_signal_flow.scm")
; 我终于开始用 load 了……

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))

(define test-seqs (list (list 1 2 3)
                        (list 4 5 6)
                        (list 7 8 9)
                        (list 10 11 12)))

(car test-seqs)
;Value: (1 2 3)

;; 将 car 函数应用于 test-seqs 中的每个元素（列表），然后将结果组成一个新的列表
(map car test-seqs)
;Value: (1 4 7 10)

(accumulate-n + 0 test-seqs)
;Value: (22 26 30)


#||
accumulate-n 过程是一个用来对多个列表进行累积操作的过程，
它接受三个参数：一个二元操作符 op，一个初始值 init，和一个包含多个列表的列表 seqs。
它的返回值是一个新的列表，它的每个元素是将 op 应用于 seqs 中的每个列表的对应位置的元素的结果。

例如，(accumulate-n + 0 test-seqs) 的意思是，
将 + 操作符应用于 test-seqs 中的每个列表的第一个元素，然后将结果放在新列表的第一个位置，
再将 + 操作符应用于 test-seqs 中的每个列表的第二个元素，然后将结果放在新列表的第二个位置，
依此类推，直到 test-seqs 中的每个列表都没有元素为止。

因此，(accumulate-n + 0 test-seqs) 的结果是 (22 26 30)，
它是由 1 + 4 + 7 + 10、2 + 5 + 8 + 11 和 3 + 6 + 9 + 12 组成的一张表。
||#