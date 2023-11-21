#||
f_smooth(x) = (f(x-dx) + f(x) + f(x+dx)) / 3.0
写一个过程，参数是 f，返回 f_smooth
||#

(define dx 0.0000001)

(define smooth
    (lambda (f)
        (lambda (x)
            (/ (+ (f (- x dx))
                  (f x)
                  (f (+ x dx)))
               3.0))))

(define ((compose f g) x)
    (f (g x)))

(define (repeated procedure times)
    (lambda (parameter)
            (iter procedure times parameter)))

(define (iter f step result)
        (if (= step 0)
            result
            (iter f (- step 1) (f result))))

((smooth square) 6)
;Value: 36.00000000000001

(((repeated smooth 7) square) 6)
;Value: 36.000000000000036

((smooth square) 5)
;Value: 25.000000000000004