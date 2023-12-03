;;;; 2.4.2 带标志数据

#||
可以将“数据抽象”视为“最小允诺原则”的一个应用。
“principle of least commitment.”
||#

;;; 带标志数据的构造函数

(define (attach-tag type-tag contents)
  (cons type-tag contents))

;;; 带标志数据的选择函数

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: 
              TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: 
              CONTENTS" datum)))

;;; 带标志数据的谓词

(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z)
  (eq? (type-tag z) 'polar))

;;; Ben 修改后的复数的直角坐标表示

;; 这里的参数 z 是不带标签的纯坐标
(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))

(define (magnitude-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
           (square (imag-part-rectangular z)))))

(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
        (real-part-rectangular z)))

(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y))) ; 加上标志，向高层传递

(define (make-from-mag-ang-rectangular r a)
  (attach-tag 
   'rectangular
   (cons (* r (cos a)) (* r (sin a))))) ; 加上标志，向高层传递

;;; Alyssa 修改后的复数的极座标表示

(define (real-part-polar z)
  (* (magnitude-polar z) 
     (cos (angle-polar z))))

(define (imag-part-polar z)
  (* (magnitude-polar z) 
     (sin (angle-polar z))))

(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))

(define (make-from-real-imag-polar x y)
  (attach-tag 
   'polar
   (cons (sqrt (+ (square x) (square y)))
         (atan y x)))) ; 加上标志，向高层传递

(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a))) ; 加上标志，向高层传递

;;; 复数的通用型选择函数

;; 参数 z 是由 type-tag 和 contents 组成的一个带标志数据
(define (real-part z)
  (cond ((rectangular? z)
         (real-part-rectangular (contents z))) ; 剥去标志，向下层传递
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type: 
               REAL-PART" z))))

(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z))) ; 剥去标志，向下层传递
        ((polar? z)
         (imag-part-polar (contents z)))
        (else (error "Unknown type: 
               IMAG-PART" z))))

(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z))) ; 剥去标志，向下层传递
        ((polar? z)
         (magnitude-polar (contents z)))
        (else (error "Unknown type: 
               MAGNITUDE" z))))

(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z))) ; 剥去标志，向下层传递
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type: 
               ANGLE" z))))

;;; 复数算术

;; 继续使用 eg2.4.1_representations_for_complex_numbers.scm 里的
;; 例如：

#||
(define (add-complex z1 z2)
  (make-from-real-imag 
   (+ (real-part z1) (real-part z2))
   (+ (imag-part z1) (imag-part z2))))
||#

;;; 复数的构造函数

(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))

(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))
