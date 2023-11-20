#||
黄金分割率是指将一条线段分成两部分，
使其中一部分与全长之比等于另一部分与这部分之比。
黄金分割率的值约为 1.61803398875。
我们可以证明，黄金分割率是变换 x -> 1+1/x 的不动点。

设 x 是变换 x -> 1+1/x 的不动点，则有：

x = 1 + 1/x
x^2 = x + 1
x^2 - x - 1 = 0

根据求根公式，可以得到：

x = (1 ± sqrt(5)) / 2

由于 x 是正数，因此只有 x = (1 + sqrt(5)) / 2 符合要求。
这个值恰好是黄金分割率的值，
因此黄金分割率是变换 x -> 1+1/x 的不动点。

证毕。

=-=……真的是这样证的吗，Bing？不管了……
||#

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(define (f x)
    (+ 1 (/ 1 x)))

(fixed-point f 1.0)
; 1.6180327868852458