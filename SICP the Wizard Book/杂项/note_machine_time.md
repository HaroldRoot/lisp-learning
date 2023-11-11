# 版本

我使用的 MIT/GNU Scheme 版本为 Stable release 12.1。

# 参考

[Machine Time (MIT/GNU Scheme 12.1)](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref/Machine-Time.html)

# 机器时间 Machine Time

上一节介绍了处理时钟时间的过程。本节将介绍处理计算机时间的过程：CPU 运行时间、实际运行时间等。这些过程对于测量执行代码所需的时间非常有用。

本节中的一些过程会操作一种名为 *ticks* 的时间表示法。tick 是一种时间单位，在此未作说明，但可通过所提供的过程将其转换为秒或从秒转换为 tick。以 ticks 为单位的计数是一个精确的整数。目前，每个 tick 代表一毫秒，但将来可能会发生变化。

# 过程：`process-time-clock`

返回自启动 Scheme 以来的进程时间（以 ticks 为单位）。进程时间由操作系统测量，是 Scheme 进程进行计算的时间。它不包括系统调用时间，但根据操作系统的不同，可能包括子进程使用的时间。

```scheme
1 ]=> (process-time-clock)

;Value: 10

1 ]=> process-time-clock

;Value: #[primitive-procedure 12 system-clock]
```

# 过程：`real-time-clock`

以 ticks 为单位，返回自启动 Scheme 以来已过去的实际时间。实际时间是指普通时钟测量的时间。

```scheme
1 ]=> (real-time-clock)

;Value: 164080

1 ]=> real-time-clock

;Value: #[primitive-procedure 13 real-time-clock]
```

# 过程：`internal-time/ticks->seconds` _ticks_

返回与 *ticks* 相对应的秒数。结果始终是实数。

```scheme
1 ]=> (internal-time/ticks->seconds 21290)

;Value: 21.29

1 ]=> (internal-time/ticks->seconds 33474836)

;Value: 33474.836

1 ]=> internal-time/ticks->seconds

;Value: #[compiled-procedure 15 ("sysclk" #x7) #x1c #xa16994]
```

# 过程：`internal-time/seconds->ticks` _seconds_

返回与*秒数*相对应的 ticks 数。*秒数*必须是实数。

```scheme
1 ]=> (internal-time/seconds->ticks 20.88)

;Value: 20880

1 ]=> (internal-time/seconds->ticks 20.83)

;Value: 20830

1 ]=> internal-time/seconds->ticks

;Value: #[compiled-procedure 16 ("sysclk" #x8) #x1c #xa16a3c]
```

# 过程：`system-clock`

返回自启动 Scheme 以来的进程时间（以秒为单位）。大致相当于

```scheme
(internal-time/ticks->seconds (process-time-clock))
```

例如：

```scheme
1 ]=> (internal-time/ticks->seconds (process-time-clock))

;Value: .04

1 ]=> (system-clock)

;Value: .03

1 ]=> system-clock 

;Value: #[compiled-procedure 17 ("sysclk" #x2) #x1c #xa16324]
```

# 过程：`runtime`

返回自启动 Scheme 以来的进程时间（以秒为单位）。但不包括垃圾回收时间。

```scheme
1 ]=> (runtime)

;Value: .03

1 ]=> runtime

;Value: #[compiled-procedure 14 ("sysclk" #x3) #x1c #xa163c4]
```

# 过程：`with-timings` _thunk receiver_

调用 *thunk*，不带参数。*thunk* 返回后，*receiver* 会调用三个参数，描述计算 *thunk* 时所用的时间：已耗费的运行时间、在垃圾回收器中耗费的时间以及已耗费的实际时间。这三个时间单位都是 ticks。

该过程最适用于性能测量，其设计开销相对较低。

```scheme
(with-timings
 (lambda () … hairy computation …)
 (lambda (run-time gc-time real-time)
   (write (internal-time/ticks->seconds run-time))
   (write-char #\space)
   (write (internal-time/ticks->seconds gc-time))
   (write-char #\space)
   (write (internal-time/ticks->seconds real-time))
   (newline)))
```

```scheme
1 ]=> with-timings

;Value: #[compiled-procedure 18 ("sysclk" #x9) #x1c #xa16b0c]
```

# 过程：`measure-interval` _runtime? procedure_

目前看不懂……qwq

```scheme
(measure-interval #t
                  (lambda (start-time)
                    (let ((v … hairy computation …))
                      (lambda (end-time)
                        (write (- end-time start-time))
                        (newline)
                        v))))
```