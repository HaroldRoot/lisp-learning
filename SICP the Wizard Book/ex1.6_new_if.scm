(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

(new-if (= 2 3) 0 5) ; 5

(new-if (= 1 1) 0 5) ; 0

(define (sqrt-iter guess x)
    (new-if (good-enough? guess x) ; 这里用了 new-if！
        guess
        (sqrt-iter (improve guess x)
                   x)))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
    (sqrt-iter 1.0 x))

; (sqrt 2)
; 1.4142156862745097
; 用原来的 if

(sqrt 2)
; Aborting!: maximum recursion depth exceeded
; 用 new-if

#||
new-if 会对所有的参数都进行求值，而不是只对选择的分支进行求值。
这样会导致一些不必要的副作用，比如无限递归、错误的结果或者性能的损失。

即使 new-if 求出了 predicate 的值为真，
new-if 还是会继续求 else-clause 的值，
而 else-clause 是 (sqrt-iter (improve guess x) x)))，
它又会调用 new-if，如此循环往复，永远无法结束。
解释器会不断地创建新的帧来保存每次调用的信息，
直到超过了最大的递归深度，然后报错。

如果想要实现一个类似 if 的过程，需要使用一种特殊的形式，
叫做延迟求值（delayed evaluation），也就是只在需要的时候
才对参数进行求值。Scheme 语言提供了一种内置的机制，
叫做惰性对（thunk），它可以将一个表达式封装成一个无参数的过程，
然后在调用的时候才执行这个表达式。
||#