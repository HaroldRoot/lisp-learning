(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define fold-right accumulate)

(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter initial sequence))

#|-------------------------------------------------------|#

;;; 测试

(fold-right / 1 (list 1 2 3))
;Value: 3/2

(fold-left / 1 (list 1 2 3))
;Value: 1/6

(fold-right list '() (list 1 2 3))
;Value: (1 (2 (3 ())))

(fold-left list '() (list 1 2 3))
;Value: (((() 1) 2) 3)

#|-------------------------------------------------------|#

#||
fold-right 和 fold-left 都是用来对一个列表进行累积操作的过程，
它们接受三个参数：一个二元操作符 op，一个初始值 initial，和一个列表 sequence。
它们的返回值是将 op 应用于 sequence 中的所有元素和 initial 的结果。

fold-right 和 fold-left 的区别在于
它们对 sequence 中的元素的遍历顺序和 op 的应用顺序不同。
fold-right 是从右向左遍历 sequence 中的元素，也就是从最后一个元素开始，
然后递归地将 op 应用于当前元素和剩余元素的累积结果。
fold-left 是从左向右遍历 sequence 中的元素，也就是从第一个元素开始，
然后迭代地将 op 应用于当前元素和累积器的结果，并更新累积器的值。

举个例子，假设我们有一个列表 (1 2 3 4)，一个操作符 +，和一个初始值 0，
那么 fold-right 和 fold-left 的计算过程如下：

fold-right (+) 0 (1 2 3 4)
= (+ 1 (fold-right (+) 0 (2 3 4))) 
= (+ 1 (+ 2 (fold-right (+) 0 (3 4)))) 
= (+ 1 (+ 2 (+ 3 (fold-right (+) 0 (4))))) 
= (+ 1 (+ 2 (+ 3 (+ 4 (fold-right (+) 0 ()))))) 
= (+ 1 (+ 2 (+ 3 (+ 4 0)))) 
= (+ 1 (+ 2 (+ 3 4))) 
= (+ 1 (+ 2 7)) 
= (+ 1 9) 
= 10

fold-left (+) 0 (1 2 3 4) 
= (iter 0 (1 2 3 4)) 
= (iter (+ 0 1) (2 3 4)) 
= (iter (+ (+ 0 1) 2) (3 4)) 
= (iter (+ (+ (+ 0 1) 2) 3) (4)) 
= (iter (+ (+ (+ (+ 0 1) 2) 3) 4) ()) 
= (+ (+ (+ (+ 0 1) 2) 3) 4) 
= (+ (+ (+ 1 2) 3) 4) 
= (+ (+ 3 3) 4) 
= (+ 6 4) 
= 10

可以看出，fold-right 和 fold-left 的最终结果是一样的，
但是它们的计算步骤和中间结果是不同的。
如果 op 是一个可交换的操作符，那么 fold-right 和 fold-left 的结果总是相同的，
但是如果 op 是一个不可交换的操作符，那么 fold-right 和 fold-left 的结果可能不同。
例如，如果 op 是 (-)，那么 fold-right (-) 0 (1 2 3 4) 的结果是 -2，
而 fold-left (-) 0 (1 2 3 4) 的结果是 -10。
||#

#|-------------------------------------------------------|#

;;; 自己想做的一些小测试

;;; 一些可交换的操作符
(+)
;Value: 0

(*)
;Value: 1

(max)
;The procedure #[arity-dispatched-procedure 12] has been called with 0 arguments; it requires at least 1 argument.

(min)
;The procedure #[arity-dispatched-procedure 13] has been called with 0 arguments; it requires at least 1 argument.

;;; 一些不可交换的操作符

(-)
;The procedure #[arity-dispatched-procedure 14] has been called with 0 arguments; it requires at least 1 argument.

(/)
;The procedure #[arity-dispatched-procedure 15] has been called with 0 arguments; it requires at least 1 argument.

(expt)
;The procedure #[compiled-procedure 16 ("arith" #xf7) #x1c #xb6f1f4] has been called with 0 arguments; it requires exactly 2 arguments.

(list) 
;Value: ()

(append)
;Value: ()

(cons)
;The procedure #[compiled-procedure 17 ("list" #x3) #x1c #xe0f76c] has been called with 0 arguments; it requires exactly 2 arguments.

#|-------------------------------------------------------|#

(fold-right * 1 (list 1 2 3))
;Value: 6

(fold-left * 1 (list 1 2 3))
;Value: 6

(fold-right + 0 (list 1 2 3))
;Value: 6

(fold-left + 0 (list 1 2 3))
;Value: 6

(fold-right max -999 (list 1 2 3))
;Value: 3

(fold-left max -999 (list 1 2 3))
;Value: 3

(fold-right min 999 (list 1 2 3))
;Value: 1

(fold-left min 999 (list 1 2 3))
;Value: 1

#|-------------------------------------------------------|#

(fold-right expt 2 (list 1 2 3))
;Value: 1
#||
(fold-right expt 2 (list 1 2 3)) 
= (expt 1 (fold-right expt 2 (list 2 3))) 
= (expt 1 (expt 2 (fold-right expt 2 (list 3)))) 
= (expt 1 (expt 2 (expt 3 (fold-right expt 2 ())))) 
= (expt 1 (expt 2 (expt 3 2))) 
= (expt 1 (expt 2 9)) 
= (expt 1 512) 
= 1
||#

(fold-left expt 2 (list 1 2 3))
;Value: 64
; ((2^1)^2)^3 = (2^2)^3 = (4^3) = 64
#||
(fold-left expt 2 (list 1 2 3)) 
= (iter 2 (list 1 2 3)) 
= (iter (expt 2 1) (list 2 3)) 
= (iter (expt (expt 2 1) 2) (list 3)) 
= (iter (expt (expt (expt 2 1) 2) 3) ()) 
= (expt (expt (expt 2 1) 2) 3) 
= (expt (expt 2 2) 3) 
= (expt 4 3) 
= 64
||#

(fold-right cons '() (list 1 2 3))
;Value: (1 2 3)

(fold-left cons '() (list 1 2 3))
;Value: (((() . 1) . 2) . 3)