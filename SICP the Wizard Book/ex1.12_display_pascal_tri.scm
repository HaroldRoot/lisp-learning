;;;; 写一个过程，使它采用递归计算过程计算出帕斯卡三角形

;;; 定义一个过程 pascal，用于计算帕斯卡三角形中第 n 行第 k 列的数字
(define (pascal n k)
    (cond ((> k n) 0)
          ((= k n) 1)
          ((= k 1) 1)
          (else (+ (pascal (- n 1) (- k 1))
                   (pascal (- n 1) k)))))

; 定义一个过程 print-row，用于打印帕斯卡三角形的一行
(define (print-row n)
    (define (loop k)
        (if (> k n) ; 循环结束条件
            (newline)
            (begin (display (pascal n k))
                   (display " ")
                   (loop (+ k 1))))) ; 循环迭代器递增语句
    (loop 1)) ; 循环迭代器初始值

; 定义一个过程 print-pascal，用于打印帕斯卡三角形的前 n 行
(define (print-pascal n)
    (define (loop i)
        (if (> i n)
            'done
            (begin (print-row i)
                   (loop (+ i 1)))))
    (loop 1))

(print-pascal 5)
#||
1 ]=> (print-pascal 5)1 
1 1 
1 2 1 
1 3 3 1 
1 4 6 4 1 
;Value: done

1 ]=> 
End of input stream reached.
Moriturus te salutat.
||#