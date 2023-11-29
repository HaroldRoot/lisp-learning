#||
ex2.21_square_list.scm

(define (square-list items)
    (if (null? items)
        '()
        (cons (square (car items))
              (square-list (cdr items)))))
||#

(define (square-list-1 items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons (square (car things))
                        answer))))
    (iter items '()))

(define test (list 1 2 3 4))

(square-list-1 test)
;Value: (16 9 4 1)

#||
square-list-1使用cons来将每个平方后的元素添加到answer的前面，
这样就可以保持原列表的顺序，但是需要反转answer。
例如，当things是(1 2 3 4)，answer是'()时，
第一次迭代后，things变成(2 3 4)，answer变成(1 '())。
第二次迭代后，things变成(3 4)，answer变成(4 (1 '()))。
第三次迭代后，things变成(4)，answer变成(9 (4 (1 '())))。
第四次迭代后，things变成'()，answer变成(16 (9 (4 (1 '()))))。
最后，返回answer，得到(16 9 4 1)。
||#

(define (square-list-2 items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things)
                  (cons answer 
                        (square (car things))))))
    (iter items '()))

(square-list-2 test)
;Value: ((((() . 1) . 4) . 9) . 16)

#||
square-list-2使用cons来将answer添加到每个平方后的元素的后面，
这样就可以避免反转answer，但是会改变原列表的顺序，并且会产生一个嵌套的列表。
例如，当things是(1 2 3 4)，answer是'()时，
第一次迭代后，things变成(2 3 4)，answer变成('() . 1)。
第二次迭代后，things变成(3 4)，answer变成(('() . 1) . 4)。
第三次迭代后，things变成(4)，answer变成((('() . 1) . 4) . 9)。第
四次迭代后，things变成'()，answer变成(((('() . 1) . 4) . 9) . 16)。
最后，返回answer，得到(((('() . 1) . 4) . 9) . 16)。
||#

(list '())
;Value: (())

(list '() '())
;Value: (() ())

(list '() 1 '() 1 '() 1 '() 1)
;Value: (() 1 () 1 () 1 () 1)