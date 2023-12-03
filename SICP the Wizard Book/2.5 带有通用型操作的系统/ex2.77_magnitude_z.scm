;;; eg2.4.3_data_directed_programming_and_additivity.scm
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types: 
             APPLY-GENERIC"
            (list op type-tags))))))
(define (magnitude z) 
  (apply-generic 'magnitude z))

;;; 至少还导入了 eg2.4.3 的 (install-rectangular-package)
;;; 不然下面不可能 (get 'magnitude '(rectangular))
;;; (install-rectangular-package) 中定义了 (put 'magnitude '(rectangular) magnitude)
;;; (define (magnitude z) (sqrt (+ (square (real-part z)) (square (imag-part z)))))

#||
Louis Reasoner 的求值过程：

(magnitude z)
(magnitude '(complex rectangular 3 4))

(apply-generic 'magnitude '((complex rectangular 3 4)))
其中参数 op <- 'magnitude
args <- '((complex rectangular 3 4)) <- (list z)

let type-tags <- '(complex) <- (map type-tag '((complex rectangular 3 4)))
let proc <- (get 'magnitude '(complex))
在这个地方出错
没有定义 <type> = '(complex)，<op> = 'magnitude 的过程 <item>
所以没办法对类型 (complex) 做操作 magnitude
||#

;;; Alyssa 的建议：
(define (install-complex-package)
  ;; imported procedures from rectangular 
  ;; and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 
          'rectangular) 
     x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) 
     r a))
  ;; internal procedures
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
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) 
         (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) 
         (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) 
         (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) 
         (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
  ;;; Alyssa 在下面加上
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  'done)



#||
现在的求值过程：

(magnitude z)
(magnitude '(complex rectangular 3 4))

(apply-generic 'magnitude '((complex rectangular 3 4)))
其中参数 op <- 'magnitude
args <- '((complex rectangular 3 4))

let type-tags <- '(complex) <- (map type-tag '((complex rectangular 3 4)))
let proc  <- car <- (get 'magnitude '(complex))

if proc 为真
(apply magnitude (map contents '((complex rectangular 3 4))))
(apply magnitude '((rectangular 3 4)))
(magnitude '(rectangular 3 4))

(apply-generic 'magnitude '((rectangular 3 4)))
其中参数 op <- 'magnitude
args <- '((rectangular 3 4))

let type-tags <- '(rectangular) <- (map type-tag '((rectangular 3 4)))
let proc  <- (lambda (z) (sqrt (+ (square (real-part z)) (square (imag-part z))))) <- (get 'magnitude '(rectangular))

if proc 为真
(apply (lambda (z) (sqrt (+ (square (real-part z)) (square (imag-part z))))) (map contents '((rectangular 3 4))))
(apply (lambda (z) (sqrt (+ (square (real-part z)) (square (imag-part z))))) '((3 4)))
(sqrt (+ (square (real-part '(3 4))) (square (imag-part '(3 4)))))
(sqrt (+ (square 3) (square 4)))
5
||#
