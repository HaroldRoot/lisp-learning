;;; 有理数加减乘除运算

(define (add-rat x y) ; 有理数加法
    (make-rat 
        (+ (* (numer x) (denom y))
            (* (numer y) (denom x)))
        (* (denom x) (denom y))))

(define (sub-rat x y) ; 有理数减法
    (make-rat 
        (- (* (numer x) (denom y))
            (* (numer y) (denom x)))
        (* (denom x) (denom y))))

(define (mul-rat x y) ; 有理数乘法
    (make-rat 
        (* (numer x) (numer y))
        (* (denom x) (denom y))))

(define (div-rat x y) ; 有理数除法
    (make-rat 
        (* (numer x) (denom y))
        (* (denom x) (denom y))))

#|--------------------------------------------|#

;;; 不够简洁的构造函数和选择函数

; (define (make-rat n d)
;     (cons n d))

; (define (numer x) (car x))

; (define (denom x) (cdr x))

;;; 更简洁的构造函数和选择函数

; (define make-rat cons)

(define numer car)

(define denom cdr)

;;; 在构造序对之前将分子和分母约化为最简单的项

(define (make-rat n d)
    (let ((g (gcd n d))) ; gcd 居然是内置过程！！！
        (cons (/ n g) (/ d g))))

#|--------------------------------------------|#

;;; 打印有理数

(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))

#|--------------------------------------------|#

;;; 测试

(define one-half (make-rat 1 2))

(print-rat one-half)
; 1/2

(define one-third (make-rat 1 3))

(print-rat (add-rat one-half one-third))
; 5/6

(print-rat (mul-rat one-half one-third))
; 1/6

(print-rat (add-rat one-third one-third))
; 2/3

#|--------------------------------------------|#

;;; 测试练习 2.1 含负数的情况

(define a (make-rat -4 -6))

(print-rat a)
; -2/-3

(define b (make-rat 4 -6))

(print-rat b)
; 2/-3

#|--------------------------------------------|#

;;; 练习2.1 使 make-rat 可以正确处理正数和负数
;;; 当分子分母同号，应该让分子分母都为正数
;;; 当分子分母异号，应该仅让分子为负数

(define (better-make-rat n d)
    (let ((g (gcd n d))) ; gcd 居然是内置过程！！！
        (if (< d 0)
            (cons (- (/ n g)) (- (/ d g)))
            (cons (/ n g) (/ d g)))))

(define c (better-make-rat -4 -6))

(print-rat c)
; 2/3

(define d (better-make-rat 4 -6))

(print-rat d)
; -2/3