#||
When we introduced compound data,
讲到复合数据的时候，
you saw Hal show you a definition
of CONS in terms of a message acceptor.
哈罗德教授展示了用消息接收的方式来定义 CONS。

04_05_what_is_pair.scm

(define (cons a b)
    (lambda (pick)
        (cond ((= pick 1) a)
              ((= pick 2) b))))

(define (car x) (x 1))

(define (cdr x) (x 2))

(car (cons 37 49)) ; 37

(define a (cons 37 49)) ; #[compound-procedure 12]
||#

#||
用传统的函数式的方法定义 CONS。
纯粹只用 LAMBDA 表达式。
阿隆佐-丘奇 Alonzo Church 发明的方法。
||#

(define (cons x y)
    (lambda (m) (m x y))) ; m stands for message

(define (car x)
    (x (lambda (a b) a))) ; x is a procedure

(define (cdr x)
    (x (lambda (a b) b)))

#||
(car (cons 35 47))
(car (lambda (m) (m 35 47)))
((lambda (m) (m 35 47)) (lambda (a b) a))
((lambda (a b) a) 35 47)
35
||#

(car (cons 35 47))
; 35