;;;; 2.2.3 序列作为一种约定的界面

#||
回顾 eg 2.2.2_count_leaves.scm

(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1)
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

(define x (cons (list 1 2) (list 3 4)))

(count-leaves x)
;Value: 4
||#

(define (sum-odd-squares tree)
    (cond ((null? tree) 0)
          ((not (pair? tree))
            (if (odd? tree)
                (square tree)
                0))
          (else (+ (sum-odd-squares (car tree))
                   (sum-odd-squares (cdr tree))))))

(define (even-fibs n)
    (define (next k)
        (if (> k n)
            '()
            (let ((f (fib k)))
                (if (even? f)
                    (cons f (next (+ k 1)))
                    (next (+ k 1))))))
    (next 0))

#||
sum-odd-squares:
- 枚举出一棵树的树叶
- 过滤它们，选出其中的奇数
- 对选出的每一个数求平方
- 用 + 累积起得到的结果，从 0 开始

even-fibs:
- 枚举从 0 到 n 的整数
- 对每个整数计算相应的斐波那契数
- 过滤它们，选出其中的偶数
- 用 cons 累积得到的结果，从空表开始
||#

#|---------------------------------------------------|#

;;; 过滤一个序列
(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
            (cons (car sequence)
                  (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence)))))

;;; 测试过滤器
(filter odd? (list 1 2 3 4 5))
;Value: (1 3 5)

#|---------------------------------------------------|#

;;; 累积工作
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5))
;Value: 15

(accumulate * 1 (list 1 2 3 4 5))
;Value: 120

(accumulate cons '() (list 1 2 3 4 5))
;Value: (1 2 3 4 5)


#|---------------------------------------------------|#

;;; 枚举出需要处理的数据序列
(define (enumerate-interval low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (+ low 1) high))))

(enumerate-interval 2 7)
;Value: (2 3 4 5 6 7)

;;; 枚举出一棵树的所有树叶
(define (enumerate-tree tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (list tree))
          (else (append (enumerate-tree (car tree))
                        (enumerate-tree (cdr tree))))))

(enumerate-tree (list 1 (list 2 (list 3 4)) 5))
;Value: (1 2 3 4 5)

#||
ex2.28_fringe.scm

(define (fringe x)
    (cond ((not (pair? x)) (list x))
          (else (cond ((and (not (null? (car x)))
                            (not (null? (cdr x))))
                       (append (fringe (car x)) (fringe (cdr x))))
                      ((and (not (null? (car x)))
                            (null? (cdr x)))
                       (fringe (car x)))
                      ((and (null? (car x))
                            (not (null? (cdr x))))
                       (fringe (cdr x)))))))

啊……对不起，我当时写的好复杂，我这就去改！qwq
||#

#|---------------------------------------------------|#

(define (new-sum-odd-squares tree)
    (accumulate +
                0
                (map square
                     (filter odd?
                             (enumerate-tree tree)))))

(define (even-fibs n)
    (accumulate cons
                '()
                (filter even?
                        (map fib 
                             (enumerate-interval 0 n)))))

;;; 测试

(define test-tree (list (list 1 2) (list 3 4)))

(sum-odd-squares test-tree)
;Value: 10

(new-sum-odd-squares test-tree)
;Value: 10

;;; /eg1.2.2_fib_iter.scm
(define (fib n)
    (fib-iter 1 0 n))

(define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))

(even-fibs 10)
;Value: (0 2 8 34)

#|---------------------------------------------------|#

;;; 序列操作 形成了一个 可以混合和匹配使用的 标准的程序元素库

(define (list-fib-squares n)
    (accumulate cons
                '()
                (map square
                     (map fib 
                          (enumerate-interval 0 n)))))

(list-fib-squares 10)
;Value: (0 1 1 4 9 25 64 169 441 1156 3025)

(define (product-of-squares-of-odd-elements sequence)
    (accumulate *
                1
                (map square
                    (filter odd? sequence))))

(product-of-squares-of-odd-elements (list 1 2 3 4 5))
;Value: 225
; 1^2 * 3^2 * 5^2 = 1 * 9 * 25 = 225