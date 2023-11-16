;;; 写出称为 product 的过程
;;; 它返回在给定范围中各点的某个函数值的乘积

(define (product term a next b)
    (if (> a b)
        1
        (* (term a) (product term (next a) next b))))

(define (identity x) x)

(product identity 1 1+ 5) ; 120

#|-----------------------------------------------------|#

;;; 用 product 定义 factorial

#||
;;; SICP MIT/09_02_functional_iter_factorial.scm
;;; Factorial of n
;;; n 的阶乘
;;; Functional version
;;; 函数式版本
(define (fact n)
    (define (iter m i)
        (cond ((> i n) m)
              (else (iter (* i m) (+ i 1)))))
    (iter 1 1))
||#

(define (factorial n)
    (product identity 1 1+ n))

(factorial 6) ; 720

#|-----------------------------------------------------|#

;;; 用数学家 John Wallis 发现的公式，计算 pi 的近似值

(define (approx-pi precision)
    (define (term-a x)
        (if (even? (+ 1 x)) 
            (+ 1 x)
            (+ 2 x)))
    (define (term-b x)
        (if (odd? (+ 2 x)) 
            (+ 2 x)
            (+ 1 x)))
    (* 4.0 (/ (product term-a 1 1+ precision)
            (product term-b 1 1+ precision))))

(approx-pi 6) ; 3.3436734693877552

(approx-pi 66) ; 3.1647768958423184

(approx-pi 666) ; 3.1439450244868543

(approx-pi 6666) ; 3.1418282347558795

(approx-pi 66666) ; 3.141616215151819

; (approx-pi 666666) ; Aborting!: maximum recursion depth exceeded

#|-----------------------------------------------------|#

;;; 写一个生成迭代计算过程的 product 过程

(define (product-iter term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))))
    (iter a 1))

(define (approx-pi-iter precision)
    (define (term-a x)
        (if (even? (+ 1 x)) 
            (+ 1 x)
            (+ 2 x)))
    (define (term-b x)
        (if (odd? (+ 2 x)) 
            (+ 2 x)
            (+ 1 x)))
    (* 4.0 (/ (product-iter term-a 1 1+ precision)
            (product-iter term-b 1 1+ precision))))

(approx-pi-iter 666666) ; 3.141595009780455
;; 算了不知道多久，真的算出来了诶，虽然只到小数点后五位是对的
;; [Done] exited with code=0 in 1618.533 seconds