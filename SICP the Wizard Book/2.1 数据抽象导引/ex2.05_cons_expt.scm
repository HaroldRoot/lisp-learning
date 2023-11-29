(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))

(define (cons a b)
    (* (fast-expt 2 a)
       (fast-expt 3 b)))

(cons 6 7)
;Value: 139968

#||
将 a 和 b 的序对表示为乘积 2^a 3^b 对应的整数
就可以只用非负整数和算数运算表示序对？

car 就是对这个整数不断地除以 2，直到不能除尽为止
cdr 就是对这个整数不断地除以 3，直到不能除尽为止
||#

(define (car z)
    (if (= 0 (remainder z 2))
        (+ 1 (car (/ z 2)))
        0))

(define (cdr z)
    (if (= 0 (remainder z 3))
        (+ 1 (cdr (/ z 3)))
        0))

(car (cons 6 7))
;Value: 6

(cdr (cons 6 7))
;Value: 7