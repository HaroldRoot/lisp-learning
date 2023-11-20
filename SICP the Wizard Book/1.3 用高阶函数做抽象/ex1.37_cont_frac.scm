;;;; 无穷连分式
;;;; k 项有限连分式

#|----------------------------------------------|#

;;; 递归

(define (cont-frac n d k)
    (define (f i)
        (if (= i k)
            (/ (n k) (d k))
            (/ (n i)
               (+ (d i)
                  (f (+ i 1))))))
    (f 1))

;;; 测试

(define (golden-ratio k)
    (/ 1
       (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k)))

(golden-ratio 1)
;Value: 1.

(golden-ratio 8)
;Value: 1.619047619047619

(golden-ratio 9)
;Value: 1.6176470588235294

(golden-ratio 10)
;Value: 1.6181818181818184

(golden-ratio 11)
;Value: 1.6179775280898876

(golden-ratio 12)
;Value: 1.6180555555555558

(golden-ratio 13)
;Value: 1.6180257510729614

#|----------------------------------------------|#

;;; 迭代

(define (cont-frac-iter n d k)
    (define (iter i result)
        (if (= i 0)
            result
            (iter (-1+ i)
                  (/ (n i)
                     (+ (d i) result)))))
    (iter (-1+ k)
          (/ (n k) (d k))))

(define (golden-ratio-iter k)
    (/ 1.0
       (cont-frac (lambda (i) 1.0)
                  (lambda (i) 1.0)
                  k)))

(golden-ratio-iter 10)
;Value: 1.6181818181818184

(golden-ratio-iter 11)
;Value: 1.6179775280898876

(golden-ratio-iter 12)
;Value: 1.6180555555555558