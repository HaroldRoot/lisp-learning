;;;; Cesaro's method for estimating Pi:
;;;; Prob(gcd(n1,n2)=1) = 6/(Pi*Pi)

(define (estimate-pi n)
    (sqrt (/ 6 (monte-carlo n cesaro))))

(define (cesaro)
    (= (gcd (rand) (rand)) 1))

;;; 一般性蒙特卡罗方法的实现
(define (monte-carlo trials experiment) ; 一个确定的实验次数，和一个确定的实验
    (define (iter remaining passed) ; 迭代，实验的剩余次数，和通过次数
        (cond ((= remaining 0) ; 如果剩余次数为0
               (/ passed trials)) ; 结果就是通过的次数除以总次数
              ((experiment) ; 如果还有实验要做，那就进行一次实验，如果实验结果为真
               (iter (-1+ remaining) ; 剩余次数减1
                     (1+ passed))) ; 通过次数加1
              (else ; 如果试验结果为假
               (iter (-1+ remaining) ; 剩余次数减1
                     passed)))) ; 通过次数不变
    (iter trials 0)) ; 以trials为剩余次数，以0为通过次数，开始迭代

;;; 随机数生成器
(define rand
    (let ((x random-init)) ; 内部状态变量以某种方式被初始化
        (lambda ()
            (set! x (rand-update x))
            x))) 