#||
n = [x, x^2, x^2, ...]
d = [1, 3, 5, ...]
||#

(define (cont-frac-iter n d k)
    (define (iter i result)
        (if (= i 0)
            result
            (iter (-1+ i)
                  (/ (n i)
                     (- (d i) result))))) ; 这里改成减号
    (iter (-1+ k)
          (/ (n k) (d k))))

(define (tan-cf x k)
    (define (n i)
        (if (= i 1)
            x
            (* x x)))
    (define (d i)
        (- (* i 2.0) 1.0))
    (cont-frac-iter n d k))

#||
也可以写 (define (d i) (- (* i 2) 1))
然后把返回值改成 (exact->inexact (cont-frac-iter n d k))

exact->inexact 是 Scheme 语言中的一个内置函数，
用于将精确数转换为不精确数。在 Scheme 中，
精确数是指可以用有理数表示的数，
而不精确数是指不能用有理数表示的数，
例如无理数和浮点数。
exact->inexact 函数接受一个精确数作为参数，
并返回一个与该精确数最接近的不精确数。
例如，(exact->inexact 1/2) 的返回值是 0.5。
||#

(tan 10)
;Value: .6483608274590866

(tan-cf 10 100)
;Value: .6483608274590866

(tan 25)
;Value: -.13352640702153587

(tan-cf 25 100)
;Value: -.1335264070215359