;;;; 2.4.1 复数的表示

;;; 构造函数

#||
;; 返回一个采用实部和虚部描述的复数
(make-from-real-imag (real-part z) 
                     (imag-part z))

;; 返回一个采用模和幅角描述的复数
(make-from-mag-ang (magnitude z) 
                   (angle z))
||#

;;; 复数算术

(define (add-complex z1 z2)
  (make-from-real-imag 
   (+ (real-part z1) (real-part z2))
   (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag 
   (- (real-part z1) (real-part z2))
   (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang 
   (* (magnitude z1) (magnitude z2))
   (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang 
   (/ (magnitude z1) (magnitude z2))
   (- (angle z1) (angle z2))))

;;; 选择函数

;; Ben 选择了复数的直角坐标表示形式

#||
(define (real-part z) (car z))
(define (imag-part z) (cdr z))

(define (magnitude z)
  (sqrt (+ (square (real-part z)) 
           (square (imag-part z)))))

(define (angle z)
  (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y) 
  (cons x y))

(define (make-from-mag-ang r a)
  (cons (* r (cos a)) (* r (sin a))))
||#

;; Alyssa 选择了复数的极座标表示形式

#||
(define (real-part z)
  (* (magnitude z) (cos (angle z))))

(define (imag-part z)
  (* (magnitude z) (sin (angle z))))

(define (magnitude z) (car z))
(define (angle z) (cdr z))

(define (make-from-real-imag x y)
  (cons (sqrt (+ (square x) (square y)))
        (atan y x)))

(define (make-from-mag-ang r a) 
  (cons r a))
||#

#||
数据抽象的规则保证了 add-complex 、 sub-complex 、 
mul-complex 和 div-complex 的同一套实现
对于 Ben 的表示或 Alyssa 的表示都能正常工作。
||#