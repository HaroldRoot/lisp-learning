(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x)))))

#||
头好痒，要长脑子了……
||#

#|--------------------------------------------|#

;;; 请直接定义 one 和 two
;;; 不用 zero 和 add-1
;;; 提示：利用代换去求值 (add-1 zero)

(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f) x))))
(lambda (f) (lambda (x) (f (((lambda (F) (lambda (X) X)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (X) X) x))))
(lambda (f) (lambda (x) (f x)))
;; 上面的输出都是 ;Value: #[compound-procedure 数字]

(add-1 1)
; 这个也是 compound procedure

((add-1 zero) 1)
; 这个也是 compound procedure？？？真没有数啊？？？？

;; 我不知道现在要干什么……

; (define (zero f)
;     (lambda (x) x))

; (define ((zero f) x)
;     x)

; (define ((add-1 n) f)
;     (lambda (x) (f ((n f) x))))

; (define (((add-1 n) f) x)
;     (f ((n f) x)))

;; 难道说 one 就是 (add-1 zero) 吗

(define one
    (lambda (f) (lambda (x) (f x)))) ; 里面是 fx

(add-1 one)
(lambda (f) (lambda (x) (f ((one f) x))))
(lambda (f) (lambda (x) (f ((lambda (X) (f X)) x))))
(lambda (f) (lambda (x) (f (f x))))

(define two
    (lambda (f) (lambda (x) (f (f x))))) ; 里面是 ffx，多了一层 f

;; 这……对吗……我怎么验证对不对呢？我看不懂啊啊啊啊……

;; 应该是对的吧，不然还能怎样

#|--------------------------------------------|#

;;; 请给出加法过程 + 的一个直接定义
;;; 不要通过反复应用 add-1

; 设 n 是一个像 zero、one、two 的“数”
; (define n
;     (lambda (f) (lambda (x) (对 x 嵌套 n 层 f))))
; 回顾
; (define (add-1 n)
;     (lambda (f) (lambda (x) (f ((n f) x)))))
; 难道说 ((n f) x) 就相当于 (对 x 嵌套 n 层 f)
; 然后 (f ((n f) x)) 就是在外面再嵌套一层 f，即 add-1 的字面意思！！！

(define (+ a b)
    (lambda (f) (lambda (x) ((b f) ((a f) x)))))

(+ zero one)
(lambda (f) (lambda (x) ((one f) ((zero f) x))))
(lambda (f) (lambda (x) ((one f) (((lambda (F) (lambda (X) X)) f) x))))
(lambda (f) (lambda (x) ((one f) ((lambda (X) X) x))))
(lambda (f) (lambda (x) ((one f) x)))
(lambda (f) (lambda (x) (((lambda (F) (lambda (X) (F X))) f) x)))
(lambda (f) (lambda (x) ((lambda (X) (f X)) x)))
(lambda (f) (lambda (x) (f x)))
; 即 zero + one = one