(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/lib2.2.3.scm")

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

(define (slow-queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap
                    (lambda (new-row)
                        (map (lambda (rest-of-queens)
                                (adjoin-position new-row k rest-of-queens))
                             (queen-cols (- k 1))))
                    (enumerate-interval 1 board-size)))))
    (queen-cols board-size))

#||
queens 和 slow-queens 都是用来求解 n 皇后问题的过程，
它们的思路都是使用回溯法，从左到右依次放置皇后，并检查是否有冲突。
它们的区别在于，queens 过程是先生成前 k-1 列的所有可能的格局，然后在第 k 列尝试每一行，
而 slow-queens 过程是先在第 k 列尝试每一行，然后生成剩余 k-1 列的所有可能的格局。
这个区别导致了它们的时间复杂度的差异。

queens 过程的时间复杂度可以用递推式 T (n) = n*T (n-1) + O (n^2) 来表示，
其中 n 是皇后的数量，O (n^2) 是检查安全性和连接列表的时间。
如果我们展开这个递推式，可以得到 T (n) = n!O (n^2) + O (n^3) + O (n^2) + ... + O (1)。
根据大 O 记法的定义，我们可以忽略低阶项和常数因子，得到 T (n) = O (n!n^2)。

slow-queens 过程的时间复杂度可以用递推式 T (n) = n^n + n*T (n-1) 来表示，
其中 n 是皇后的数量，n^n 是在第 n 列尝试每一行的时间，n*T (n-1) 是生成剩余 n-1 列的所有可能的格局的时间。
如果我们展开这个递推式，可以得到 T (n) = n^n + n^(n-1) + n^(n-2) + ... + n + 1。
根据大 O 记法的定义，我们可以忽略低阶项和常数因子，得到 T (n) = O (n^n)。

因此，queens 过程的时间复杂度是 O (n!n^2)，
而 slow-queens 过程的时间复杂度是 O (n^n)。
显然，O (n!n^2) 比 O (n^n) 要小得多，
所以 queens 过程比 slow-queens 过程要快得多。
||#

(define empty-board '())

(define (adjoin-position row col rest-of-queens)
    (cons row rest-of-queens)) 

(define (safe? k positions)
    (iter-check (car positions)
                (cdr positions)
                1))

(define (iter-check row-of-new-queen rest-queens col-distance)
    (if (null? rest-queens)
        #t
        (let ((row-of-current-checking (car rest-queens)))
            (if (or (= row-of-new-queen row-of-current-checking) 
                    (= col-distance (abs (- row-of-new-queen row-of-current-checking))))
                #f
                (iter-check row-of-new-queen 
                            (cdr rest-queens)
                            (+ col-distance 1))))))

(define (report-test elapsed-time)
    (newline)
    (display "总计用时：")
    (display elapsed-time))

(define (start-test procedure parameter start-time)
    (newline)
    (display (length (procedure parameter)))
    (report-test (- (real-time-clock) start-time)))

(start-test queens 8 (real-time-clock))

(start-test slow-queens 8 (real-time-clock))

#||
1 ]=> (start-test queens 8 (real-time-clock))
92
总计用时：59
;Unspecified return value

1 ]=> (start-test slow-queens 8 (real-time-clock))
92
总计用时：109212
;Unspecified return value

1 ]=> 
End of input stream reached.
Moriturus te salutat.

[Done] exited with code=0 in 109.348 seconds
||#