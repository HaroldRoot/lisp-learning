;;;; 练习 2.78

#||
修改 2.4.2 节中 type-tag、contents 和 attach-tag 的定义，
使我们的通用算术系统可以利用 Scheme 的内部类型系统。
||#

#||
/2.4 抽象数据的多重表示/eg2.4.2_tagged_data.scm

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
||#

(define (attach-tag type-tag contents)
  ;; 所有 Lisp 实现都有自己的类型系统
  ;; 如果数据对象 contents 已经有了 Scheme 内部类型系统能识别的标志
  ;; 就不要给它添加标志符号 scheme-number 了
  (if (number? contents)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) 'scheme-number) ; 假装 datum 有 tag
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum: 
                      TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum:
                      CONTENT" datum))))