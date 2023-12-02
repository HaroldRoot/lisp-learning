;;; 97 页书上的例子

(define a 1)

(define b 2)

(list a b)
;Value: (1 2)

(list 'a 'b)
;Value: (a b)

(list 'a b)
;Value: (a 2)

;;; 在 Scheme 里可以不写结束引号，写会怎么样？

; (list 'a' 'b')
; ;Unbalanced close parenthesis: #\)

(list 'a' b)
;Value: (a b)

(list 'a' a-very-long-symbol)
;Value: (a a-very-long-symbol)

(list 'a'                      a-very-long-symbol)
;Value: (a a-very-long-symbol)

(list 'a' b b)
;Value: (a b 2)
; 印证了书上的原话：一个单引号的意义就是引用下一个对象

#|---------------------------------------------------------|#

;;; 引号用于复合对象

(car '(a b c))
;Value: a

(cdr '(a b c))
;Value: (b c)

(quote (a b c))
;Value: (a b c)

(list 'car (list 'quote '(a b c)))
;Value: (car (quote (a b c)))

#|---------------------------------------------------------|#

;;; 基本过程 eq?

(define (memq item x)
    (cond ((null? x) false)
          ((eq? item (car x)) x)
          (else (memq item (cdr x)))))

(memq 'apple '(pear banana prune))
;Value: #f

(memq 'apple '( x (apple sause) y apple pear))
;Value: (apple pear)