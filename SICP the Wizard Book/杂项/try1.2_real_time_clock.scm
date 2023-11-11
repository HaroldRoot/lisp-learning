;;;; 用运行时长比较久的程序，来测试各种计时过程

(define (fib n) (fib-iter 1 0 n))

(define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))

(define (try timer)
    (let ((start-time (timer)))
        (fib 99999)
        (newline)
        (display "运行用时：")
        (display (- (timer) start-time))
        (newline)))

#||
(process-time-clock)
返回自启动 Scheme 以来的进程时间（以 ticks 为单位）。
进程时间由操作系统测量，是 Scheme 进程进行计算的时间。
它不包括系统调用时间，但根据操作系统的不同，可能包括子进程使用的时间。
||#
(try process-time-clock)
; 运行用时：290

#||
(real-time-clock)
以 ticks 为单位，返回自启动 Scheme 以来已过去的实际时间。
实际时间是指普通时钟测量的时间。
||#
(try real-time-clock)
; 运行用时：258

#||
(system-clock)
返回自启动 Scheme 以来的进程时间（以秒为单位）。
||#
(try system-clock)
; 运行用时：.25

#||
(runtime)
返回自启动 Scheme 以来的进程时间（以秒为单位）。
但不包括垃圾回收时间。
||#
(try runtime)
; 运行用时：.22999999999999998

(display (fib 99999))
; 太长了，不展示了