;;;; n<3：f(n)=n
;;;; n>=3: f(n)=f(n-1)+2f(n-2)+3f(n-3)

;;; 递归计算过程版本

(define (recursif n)
    (if (< n 3) n
                (+ (recursif (- n 1))
                   (+ (* 2 (recursif (- n 2)))
                      (* 3 (recursif (- n 3)))))))

(recursif 3) ; 4
(recursif 4) ; 11

;;; 迭代计算过程版本

(define (f n)
    (iteratif 2 1 0 n))

(define (iteratif a b c count)
    (if (= count 0)
        c
        (iteratif (+ a (+ (* 2 b) (* 3 c)))
                  a
                  b
                  (- count 1))))
    
(f 3) ; 4
(f 4) ; 11