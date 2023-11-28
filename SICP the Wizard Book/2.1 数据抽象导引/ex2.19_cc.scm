#||
;;;; 第26页的实例：换零钱方式的统计

(define (count-change amount)
    (cc amount 5)) ; 现金数为输入的参数，硬币种类有5种

(define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1) ; 如果现金数正好清零，算作有1种换零钱的方式
          ((or (< amount 0) (= kinds-of-coins 0)) 0) ; 如果现金数变得小于0，或者硬币种类没了，就不算是换零钱的方式
          (else (+ (cc amount 
                       (- kinds-of-coins 1))
                   (cc (- amount 
                          (first-denomination kinds-of-coins))
                       kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
          ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50)))

(count-change 100) ; 292

(count-change 11) ; 4
||#

(define us-coins (list 50 25 10 5 1))

(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (no-more? coin-values)) 0)
          (else 
            (+ (cc amount
                   (except-first-denomination coin-values))
               (cc (- amount
                      (first-denomination coin-values))
                   coin-values)))))

#|--------------------------------------------------------------|#

(define first-denomination car)

(define except-first-denomination cdr)

(define no-more? null?)

;;; 测试
(cc 100 us-coins)
;Value: 292

;;; 表 coin-values 的排列顺序会影响 cc 给出的回答吗？
(define still-us-coins (list 1 10 50 5 25))

(cc 100 still-us-coins)
;Value: 292
; 不会