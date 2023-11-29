(define (flatmap proc seq)
    (accumulate append '() (map proc seq)))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (filter predicate sequence)
    (cond ((null? sequence) '())
          ((predicate (car sequence))
            (cons (car sequence)
                  (filter predicate (cdr sequence))))
          (else (filter predicate (cdr sequence)))))

#|---------------------------------------------------|#

;;; 嵌套的映射
;;; 生成集合 s 的元素的所有可能排序方式

(define (permutations s)
    (if (null? s)
        (list '())
        (flatmap (lambda (x)
                         (map (lambda (p) (cons x p))
                              (permutations (remove x s))))
                 s)))
#||
对于集合 s 中的每一个元素 x，
生成一个去掉它之后的序列 (remove x s)，
然后求这个序列的全排列 (permutations (remove x s))，
然后对于这个全排列中的每一种排列 p（每一个元素），
将 x 分别加到它们的前面，得到 (cons x p)，
然后 faltmap 的作用是把不同的 (cons x p) 组合成一个表。
||#

;;; 返回一个将 sequence 中的 item 去掉后得到的序列
(define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
            sequence))

(permutations (list 1 2 3))
;Value: ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))