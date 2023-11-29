;;;; 八皇后谜题

(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/lib2.2.3.scm")
; 需要 filter，flatmap，enumerate-interval

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (rest-of-queens)
                        (map (lambda (new-row)
                                (adjoin-position new-row k rest-of-queens))
                             (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    (queen-cols board-size))

;;; 棋盘格局的表示方式
; (list 3 7 2 8 5 1 4 6)
; 书上的例图，第1列的皇后在第3行……第8列的行后在第6行。

;;; 棋盘格局集合的表示方式
; (list (list 3 7 2 8 5 1 4 6) (list ...) ... (list ...))

#||
(queens board-size) 
返回在 board-size × board-size 棋盘上
放 board-size 个皇后的所有解的序列。

(queen-cols k)
返回在棋盘的前 k 列中放皇后的所有格局的序列。

当 k=0 时，(queen-cols 0) 应该返回一个空序列 
(list empty-board)，即 (list '())。;Value: (())

按一个方向处理棋盘，每次在每一列里放一个皇后。

如果现在已经放好了 k-1 个皇后，
她们的所有格局的序列保存在 (queen-cols (- k 1))，
遍历这个序列中的每一种格局，记作 rest-of-queens，
rest-of-queens 例如 (list 3 7 2 8 5 1)，
从 1 到 board-size 遍历，
选出要把第 k 个皇后放在第 k 列的哪一行，
记作 new-row，然后把位置 (new-row, k) 添加进 rest-of-queens。
不过我们并不记录第几列，而是让元素的顺序自动记录它是第几列，
所以假设 new-row 是 4，(adjoin-position 4 7 (list 3 7 2 8 5 1))
的结果应该是 (list 4 3 7 2 8 5 1)。——这里采用逆序添加
flatmap 会生成 (list 1..board-size 3 7 2 8 5 1)，
然后这个由 list 组成的 list 会经过过滤器，
每一个 list 中 list 又会被记作 positions，
所以 (list 4 3 7 2 8 5 1) 就是一个 positions，
如果 (safe? 7 (list 4 3 7 2 8 5 1)) 通过过滤，
这种 positions 就会和其他通过过滤的 positions 
一起被加入 (queen-cols k) 的序列中。
||#

(define empty-board '())

(define (adjoin-position row col rest-of-queens)
    (cons row rest-of-queens)) ; 只显式记录所在行，所在列由顺序自动记录

; (safe? 7 (list 4 3 7 2 8 5 1))
(define (safe? k positions)
    (iter-check (car positions)
                (cdr positions)
                1))

(define (iter-check row-of-new-queen rest-queens col-distance)
    (if (null? rest-queens)
        #t
        (let ((row-of-current-checking (car rest-queens)))
            (if (or (= row-of-new-queen row-of-current-checking) ; 不在同一行
                    (= col-distance (abs (- row-of-new-queen row-of-current-checking)))) ; 行差距不等于列差距，说明不在对角线上
                #f
                (iter-check row-of-new-queen 
                            (cdr rest-queens)
                            (+ col-distance 1))))))

(length (queens 8))
;Value: 92
; 正解

; (length (queens 11))
; ;Value: 2680
; 正解

(for-each (lambda (position)
                  (begin (newline)
                         (display position)))
          (queens 8))
#||
(4 2 7 3 6 8 5 1)
(5 2 4 7 3 8 6 1)
(3 5 2 8 6 4 7 1)
(3 6 4 2 8 5 7 1)
(5 7 1 3 8 6 4 2)
(4 6 8 3 1 7 5 2)
(3 6 8 1 4 7 5 2)
(5 3 8 4 7 1 6 2)
(5 7 4 1 3 8 6 2)
(4 1 5 8 6 3 7 2)
(3 6 4 1 8 5 7 2)
(4 7 5 3 1 6 8 2)
(6 4 2 8 5 7 1 3)
(6 4 7 1 8 2 5 3)
(1 7 4 6 8 2 5 3)
(6 8 2 4 1 7 5 3)
(6 2 7 1 4 8 5 3)
(4 7 1 8 5 2 6 3)
(5 8 4 1 7 2 6 3)
(4 8 1 5 7 2 6 3)
(2 7 5 8 1 4 6 3)
(1 7 5 8 2 4 6 3)
(2 5 7 4 1 8 6 3)
(4 2 7 5 1 8 6 3)
(5 7 1 4 2 8 6 3)
(6 4 1 5 8 2 7 3)
(5 1 4 6 8 2 7 3)
(5 2 6 1 7 4 8 3)
(6 3 7 2 8 5 1 4)
(2 7 3 6 8 5 1 4)
(7 3 1 6 8 5 2 4)
(5 1 8 6 3 7 2 4)
(1 5 8 6 3 7 2 4)
(3 6 8 1 5 7 2 4)
(6 3 1 7 5 8 2 4)
(7 5 3 1 6 8 2 4)
(7 3 8 2 5 1 6 4)
(5 3 1 7 2 8 6 4)
(2 5 7 1 3 8 6 4)
(3 6 2 5 8 1 7 4)
(6 1 5 2 8 3 7 4)
(8 3 1 6 2 5 7 4)
(2 8 6 1 3 5 7 4)
(5 7 2 6 3 1 8 4)
(3 6 2 7 5 1 8 4)
(6 2 7 1 3 5 8 4)
(3 7 2 8 6 4 1 5)
(6 3 7 2 4 8 1 5)
(4 2 7 3 6 8 1 5)
(7 1 3 8 6 4 2 5)
(1 6 8 3 7 4 2 5)
(3 8 4 7 1 6 2 5)
(6 3 7 4 1 8 2 5)
(7 4 2 8 6 1 3 5)
(4 6 8 2 7 1 3 5)
(2 6 1 7 4 8 3 5)
(2 4 6 8 3 1 7 5)
(3 6 8 2 4 1 7 5)
(6 3 1 8 4 2 7 5)
(8 4 1 3 6 2 7 5)
(4 8 1 3 6 2 7 5)
(2 6 8 3 1 4 7 5)
(7 2 6 3 1 4 8 5)
(3 6 2 7 1 4 8 5)
(4 7 3 8 2 5 1 6)
(4 8 5 3 1 7 2 6)
(3 5 8 4 1 7 2 6)
(4 2 8 5 7 1 3 6)
(5 7 2 4 8 1 3 6)
(7 4 2 5 8 1 3 6)
(8 2 4 1 7 5 3 6)
(7 2 4 1 8 5 3 6)
(5 1 8 4 2 7 3 6)
(4 1 5 8 2 7 3 6)
(5 2 8 1 4 7 3 6)
(3 7 2 8 5 1 4 6)
(3 1 7 5 8 2 4 6)
(8 2 5 3 1 7 4 6)
(3 5 2 8 1 7 4 6)
(3 5 7 1 4 2 8 6)
(5 2 4 6 8 3 1 7)
(6 3 5 8 1 4 2 7)
(5 8 4 1 3 6 2 7)
(4 2 5 8 6 1 3 7)
(4 6 1 5 2 8 3 7)
(6 3 1 8 5 2 4 7)
(5 3 1 6 8 2 4 7)
(4 2 8 6 1 3 5 7)
(6 3 5 7 1 4 2 8)
(6 4 7 1 3 5 2 8)
(4 7 5 2 6 1 3 8)
(5 7 2 6 3 1 4 8)
;Unspecified return value
||#