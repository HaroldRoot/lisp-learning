;;;; 书上第 35 页

;;; 在对整数 n 调用下面的 timed-prime-test 过程时，
;;; 将打印出 n 并检查 n 是否为素数。
;;; 如果 n 是素数，
;;; 过程将打印出三个星号，
;;; 随后是执行这一检查所用的时间量。

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

#|-------------------------------------------------|#

;;; eg1.2.6_smallest_divisor.scm

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond 
          ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
    (= (remainder b a) 0))

#|-------------------------------------------------|#

;;; 判断素数的办法

(define (prime? n)
    (= (smallest-divisor n) n))


#|-------------------------------------------------|#

;;; 测试

(timed-prime-test 19999999)
#||
19999999 *** 0.
;Unspecified return value

未指定返回值是指当一个函数没有明确返回任何值时，
不同的实现可能返回不同的值。这意味着你不能使用这个返回值，
因为它可能是不可预测的。你使用的实现可能选择了一个具体的值，
叫做未指定值，它通常用 #<unspecified> 表示。

report-prime 函数没有返回任何值，
所以它的返回值是未指定的。当调用 timed-prime-test 函数时，
它会打印出一个数字和一个星号，然后返回 report-prime 函数的返回值，
也就是未指定值。解释器可能会在输出中显示这个未指定值，
或者忽略它，或者报错。
||#