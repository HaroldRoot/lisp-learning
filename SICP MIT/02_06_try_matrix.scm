;;;; 尝试在 scheme 中实现矩阵乘法

;;; 向量点乘，结果叫点积 dot product，又称数量积，或标量积 scalar product

#||
设两个向量 a = [a1, a2, a3, ..., an]
b = [b1, b2, b3, ..., bn]
则它们的点积 a·b = a1*b1+a2*b2+...+an*bn

把（纵列）向量当作 n×1 矩阵
使用矩阵乘法，点积还可以写为
a·b = (a^T)*b
这里的 a^T 指示矩阵 a 的转置
||#

(define (dot v w)
    (reduce + (map * v w)))

(define a '(1 2 3))

(define b '(4 5 6))

(dot a b)