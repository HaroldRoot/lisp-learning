;;; Iterative

;;; 有点像 for 循环
(define (sum term a next b)
    (define (iter j ans)
        (if (> j b)
            ans
            (iter (next j)
                (+ (term j) ans))))
    (iter a 0))