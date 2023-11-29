(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/ex2.36_accumulate_n.scm")
; 获取 accumulate 函数和 accumulate-n 函数

;;; 点积
(define (dot-product v w)
    (accumulate + 0 (map * v w)))

;;; 测试
(define test-vector (list 1 2 3 4))

(dot-product test-vector test-vector)
;Value: 30
; 1 + 4 + 9 + 16 = 30

#|----------------------------------------------|#

;;; 矩阵 m 和向量 v 之间的乘法
;;; 返回一个向量 t
;;; 取矩阵 m 中的各列 col 
;;; 计算 col 和向量 v 的点积
(define (matrix-*-vector m v)
    (map (lambda (col)
            (dot-product col v))
         m))

;;; 测试
(define test-matrix (list (list 1 2 3 4)
                          (list 4 5 6 6)
                          (list 6 7 8 9)))

(matrix-*-vector test-matrix test-vector)
;Value: (30 56 80)

#|----------------------------------------------|#

;;;; 逆矩阵
;;;; 返回一个矩阵 n
;;;; 其中 n_ij = m_ji
(define (transpose mat)
    (accumulate-n cons
                  '() 
                  mat))

(transpose test-matrix)
;Value: ((1 4 6) (2 5 7) (3 6 8) (4 6 9))

#||
将 cons 操作符应用于 test-matrix 中的每个列表的第一个元素，然后将结果放在新列表的第一个位置，
再将 cons 操作符应用于 test-matrix 中的每个列表的第二个元素，然后将结果放在新列表的第二个位置，
依此类推，直到 test-matrix 中的每个列表都没有元素为止。

因此，(transpose test-matrix) 的结果是 ((1 4 6) (2 5 7) (3 6 8) (4 6 9))，
它是由 (cons 1 (cons 4 (cons 6 '())))、
(cons 2 (cons 5 (cons 7 '())))、
(cons 3 (cons 6 (cons 8 '()))) 和 
(cons 4 (cons 6 (cons 9 '()))) 组成的。
||#

(cons 1 (cons 4 (cons 6 '())))
;Value: (1 4 6)

; (append 1 (append 4 (append 6 '())))
; ;The object 6, passed as an argument to append, is not the correct type.

(list 1 (list 4 (list 6 '())))
;Value: (1 (4 (6 ())))

#|----------------------------------------------|#

(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (row) (matrix-*-vector cols row))
             m)))

(matrix-*-matrix test-matrix (transpose test-matrix))
;Value: ((30 56 80) (56 113 161) (80 161 230))