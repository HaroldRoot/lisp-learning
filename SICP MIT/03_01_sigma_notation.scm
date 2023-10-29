(define (sum-int a b)
    (if (> a b)
        0 ; 最简单的情形的答案可以直接作为结果
        ;; 子问题：对“比整个问题的规模少1的整数序列”进行求和
        (+ a (sum-int (1+ a) b))))

(define (sum-sq a b) ; 不同的过程名字
    (if (> a b) ; 相同的 predicate
        0 ; 相同的 consequence
        (+ (square a) (sum-sq (1+ a) b)))) ; 相似的 alternative

(define (pi-sum a b)
    (if (> a b)
        0
        (+ (/ 1 (* a (+ a 2))) 
            (sum-sq (+ a 4) b))))

(define (sum term a next b) 
;; term 和 next 不是数字，而是对数字进行计算的过程
;; 给 term 一个下标，term 会计算出这个下标所对应的值
;; next 会根据一个下标计算下一个下标
    (if (> a b)
        0
        (+ (term a)
            (sum term (next a) next b))))