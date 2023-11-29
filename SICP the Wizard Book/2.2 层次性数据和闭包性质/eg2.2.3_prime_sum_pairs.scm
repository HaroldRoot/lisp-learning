#||
给定了自然数 n
找出所有不同的 有序对 i 和 j
其中 1 <= j < i <= n
使得 i + j 是素数

- 生成出所有小于等于 n 的正自然数的有序对
- 通过过滤，得到那些和为素数的有序对
- 对每个通过了过滤的序对 (i,j)，产生出一个三元组 (i,j,i+j)
||#

(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/eg2.2.3_signal_flow.scm")
; 引入 filter，accumulate，enumerate-interval

(enumerate-interval 1 6)
;Value: (1 2 3 4 5 6)

(accumulate append
            '()
            (map (lambda (i)
                    (map (lambda (j) (list i j))
                         (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 6)))
;Value: ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3) (5 1) (5 2) (5 3) (5 4) (6 1) (6 2) (6 3) (6 4) (6 5))

#|----------------------------------------------------------------------------------------------------|#

;;; 乱试一下

(accumulate cons
            '()
            (map (lambda (i)
                    (map (lambda (j) (list i j))
                         (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 6)))
;Value: (() ((2 1)) ((3 1) (3 2)) ((4 1) (4 2) (4 3)) ((5 1) (5 2) (5 3) (5 4)) ((6 1) (6 2) (6 3) (6 4) (6 5)))

(accumulate list
            '()
            (map (lambda (i)
                    (map (lambda (j) (list i j))
                         (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 6)))
;Value: (() (((2 1)) (((3 1) (3 2)) (((4 1) (4 2) (4 3)) (((5 1) (5 2) (5 3) (5 4)) (((6 1) (6 2) (6 3) (6 4) (6 5)) ()))))))

#|----------------------------------------------------------------------------------------------------|#

(define (flatmap proc seq)
    (accumulate append '() (map proc seq)))

(define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
    (map make-pair-sum
         (filter prime-sum?
                 (flatmap
                    (lambda (i)
                            (map (lambda (j) (list i j))
                                 (enumerate-interval 1 (- i 1))))
                    (enumerate-interval 1 n)))))

(load "SICP the Wizard Book/1.2 过程与它们所产生的计算/ex1.28_2_miller-rabin-nontrivial.scm")
; 引入 prime?

(prime? 7)
;Value: #t

#|----------------------------------------------------------------------------------------------------|#

;;; 测试

(prime-sum-pairs 6)
;Value: ((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 11))

