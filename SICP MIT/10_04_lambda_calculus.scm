;;;; "Lambda Calculus" Mutable Data

#||
供对比：
(define (cons x y)
    (lambda (m) (m x y))) ; m stands for message
(define (car x)
    (x (lambda (a b) a))) ; x is a procedure
(define (cdr x)
    (x (lambda (a b) b)))
||#

(define (cons x y)
    (lambda (m)
        (m x
           y
           (lambda (n) (set! x n)) ; permission
           (lambda (n) (set! y n)))))

(define (car x)
    (x (lambda (a d sa sd) a)))

(define (cdr x)
    (x (lambda (a d sa sd) d)))

(define (set-car! x y)
    (x (lambda (a d sa sd) (sa y))))

(define (set-cdr! x y)
    (x (lambda (a d sa sd) (sd y))))

;;; 下面进行查值测试

(car (cons 35 47)) ; 35

(define a (cons 1 2))
(define b (cons a a))

a ; #[compound-procedure 12]
b ; #[compound-procedure 13]

(car a) ; 1
(cdr a) ; 2
(car b) ; #[compound-procedure 12]
(cdr b) ; #[compound-procedure 12]

#||
(caar b)
(cdar b)
(cadr b)
(cddr b)
这些全都会报错：
The object #[compound-procedure 13], 
passed as an argument to safe-cdr, 
is not the correct type.
||#

(car (car b)) ; 1
(cdr (car b)) ; 2
(car (cdr b)) ; 1
(cdr (cdr b)) ; 2

;;; 下面进行改值测试

(set-car! (car b) 3) ; 1

(car a) ; 3
(cdr a) ; 2
(car (car b)) ; 3
(cdr (car b)) ; 2
(car (cdr b)) ; 3
(cdr (cdr b)) ; 2

#||
试用代换模型推导发生了什么（引入赋值后，代换模型不再一定有效，但我随便试试看）：
(set-car! (car b) 3)
(set-car! (car (cons a a)) 3)
(set-car! (car (cons (cons 1 2) (cons 1 2))) 3)
(set-car! (car (cons (cons 1 2) (cons 1 2))) 3)
在这里会把 (cons 1 2) 展开成：
(lambda (m) (m 1 2 (lambda (n) (set! 1 n)) (lambda (n) (set! 2 n))))
显然其中的 (set! 1 n) 是不合理的，把数字 1 赋值成 n 是什么鬼啦……
qwq 所以说，代换模型不存在了！
||#