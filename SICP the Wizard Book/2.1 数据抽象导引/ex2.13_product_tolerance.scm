#||
在误差 tolerance 为很小的百分数的条件下
存在着一个简单公式，
可以从两个被乘区间的误差
算出乘积的百分数误差值。

可以假定所有的数为正，
简化这一问题。

如果 x 是区间，c 表示中心点，t 表示百分数误差值：
x = [c*(1-0.5*t), c*(1+0.5*t)]
其中，当误差为 67% 时，t=0.67 而不是 67

x = [Cx*(1-0.5*Tx), Cx*(1+0.5*Tx)]
y = [Cy*(1-0.5*Ty), Cy*(1+0.5*Ty)]

x*y = [Cx*Cy*(1-0.5*(Tx+Ty))+0.25*Tx*Ty, 
       Cx*Cy*(1+0.5*(Tx+Ty))+0.25*Tx*Ty]

0.25*Tx*Ty 很小，可以忽略不计，则
x*y = [Cx*Cy*(1-0.5*(Tx+Ty)), 
       Cx*Cy*(1+0.5*(Tx+Ty))]
两个区间的乘积的误差，约等于两个分区的误差的加和
||#


(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

#|-----------------------------------------|#

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2))

#|-----------------------------------------|#

;;; c 是中心点，p 是百分比，w 是区间宽
(define (make-center-percent c p)
    (let ((w (* c (/ p 100.0))))
        (make-center-width c w)))

(define (percent x)
    (let ((c (/ (+ (upper-bound x) (lower-bound x)) 2.0))
          (w (/ (- (upper-bound x) (lower-bound x)) 2.0)))
        (* (/ w c) 100)))

#|-----------------------------------------|#

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))

#|-----------------------------------------|#

;;; 测试

(define aaa (make-center-percent 10 0.6))

(define bbb (make-center-percent 10 0.7))

(percent (mul-interval aaa bbb))
;Value: 1.299945402293115
; 0.6 + 0.7 = 1.3 非常接近