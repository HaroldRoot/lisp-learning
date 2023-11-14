(define (cube x) (* x x x))

;;; 计算从a到b的各整数之和
(define (sum-integers a b)
    (if (> a b)
        0
        (+ a (sum-integers (+ a 1) b))))

;;; 计算给定范围内的整数的立方之和
(define (sum-cubes a b)
    (if (> a b)
    0
    (+ (cube a) (sum-cubes (+ a 1) b))))

;;; 计算某种序列之和
;;; 1/(1*3) + 1/(5*7) + 1/(9*11)
;;; 非常缓慢地收敛到 pi/8
(define (pi-sum a b)
    (if (> a b)
        0
        (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

#||
公共的基础模式
(define (<name> a b)
    (if (> a b)
        0
        (+ (<term> a)
           (<name> (<next> a) b))))
||#

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (new-sum-cubes a b)
    (sum cube a inc b))

(new-sum-cubes 1 10) ; 3025

(define (identity x) x)
(define (new-sum-integers a b)
    (sum identity a inc b))

(new-sum-integers 1 10) ; 55

(define (new-pi-sum a b)
    (define (pi-term x)
        (/ 1.0 (* x (+ x 2))))
    (define (pi-next x)
        (+ x 4))
    (sum pi-term a pi-next b))

(* 8 (new-pi-sum 1 1000)) ; 3.139592655589783

(* 8 (new-pi-sum 1 10000)) ; 3.141392653591793

;;; 求出函数f在范围a和b之间的定积分的近似值
(define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(integral cube 0 1 0.01) ; .24998750000000042

(integral cube 0 1 0.001) ; .249999875000001

;;; cube在0和1间积分的精确值是1/4