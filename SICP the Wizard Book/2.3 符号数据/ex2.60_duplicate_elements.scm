#lang sicp


;;; 之前我们指定一个集合将表示为一个没有重复项的列表

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

#||
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) 
         '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) 
                                 set2)))
        (else (intersection-set (cdr set1) 
                                set2))))
||#

(define (union-set set1 set2)
  (drop-duplicates (append set1 set2) '()))

(define (drop-duplicates objects stack)
  (if (null? objects)
      (reverse stack)
      (let ((current-object (car objects))
            (remaining-objects (cdr objects)))
            (if (element-of-set? current-object stack)
                (drop-duplicates remaining-objects stack)
                (drop-duplicates remaining-objects
                                 (cons current-object stack))))))

; 现在假设我们允许重复。
; 例如，集合 {1,2,3} 可以表示为列表 (2 3 2 1 3 2 2) 。
(define test-set-1 (list 2 3 2 1 3 2 2))
(define test-set-2 (list 1 2 3 4))

#||
(union-set test-set-1 test-set-2)
; (2 3 1 4)

(intersection-set test-set-1 test-set-2)
; (2 3 2 1 3 2 2)

(intersection-set test-set-2 test-set-1)
; (1 2 3)

(adjoin-set 3 test-set-1)
; (2 3 2 1 3 2 2)
; 3 已经在 test-set-1 里了，就直接返回 test-set-1 

(adjoin-set 4 test-set-1)
; (4 2 3 2 1 3 2 2)
; 4 不在 test-set-1 里，就返回 (cons 4 test-set-1)
||#

;;; 设计对允许重复的表示进行操作的过程 element-of-set? 、
;;; adjoin-set 、 union-set 和 intersection-set


;;; 允许重复，adjoin-set 直接无脑添加新元素即可
(define (adjoin-set x set)
  (cons x set))

(display "测试 adjoin-set\n")

(adjoin-set 3 test-set-1) ; (3 2 3 2 1 3 2 2)

(adjoin-set 4 test-set-1) ; (4 2 3 2 1 3 2 2)

(newline)

;;; union-set 用原来的就行，而且结果还会自动去重
(display "测试 union-set\n")

(union-set test-set-1 test-set-2) ; (2 3 1 4)

(union-set test-set-1 test-set-1) ; (2 3 1)

(newline)

;;; 原来的没有重复的集合的交集过程：
;;; 遍历 set-1 的每一个元素，如果它在 set-2 里也有，就加入结果集合
;;; 现在：再加一步检查是否已在结果集合里
(define (intersection-set set1 set2)
  (define (iter set1 result)
    (if (or (null? set1) (null? set2))
        (reverse result)
        (let ((current-element (car set1))
              (remaining-elements (cdr set1)))
          (if (and (element-of-set? current-element set2)
                   (not (element-of-set? current-element result)))
              (iter remaining-elements (cons current-element result))
              (iter remaining-elements result)))))
  (iter set1 '()))

(display "测试 intersection-set\n")

(intersection-set test-set-1 test-set-2) ; (2 3 1)

(intersection-set test-set-2 test-set-1) ; (1 2 3)

#||
element-of-set? 的时间复杂度是 O(n)，
其中 n 是 set 的长度。这是因为这个过程需要遍历 set 的所有元素，检查是否有和 x 相等的元素。

adjoin-set 的时间复杂度是 O(1)，
因为这个过程只是在 set 的前面添加一个元素 x，不需要遍历 set。

union-set 的时间复杂度是 O(mn)，
其中 m 和 n 分别是 set1 和 set2 的长度。
这是因为这个过程需要先用 append 把两个集合连接起来，
然后用 drop-duplicates 去除重复的元素。
append 的时间复杂度是 O(m)，
drop-duplicates 的时间复杂度是 O(mn)，
因为它需要对每个元素调用 element-of-set? 来检查是否已经在 stack 中出现过。

intersection-set 的时间复杂度是 O(mn)，
其中 m 和 n 分别是 set1 和 set2 的长度。
这是因为这个过程需要遍历 set1 的所有元素，
对每个元素检查是否在 set2 中出现过，
以及是否已经在 result 中出现过。
这两个检查都需要调用 element-of-set?，
所以每个元素的时间复杂度是 O(n)。
||#

#||
除了 adjoin-set 的时间复杂度从 O(n) 变成 O(1) 以外，
其他的时间复杂度没变。但是对允许重复的集合而言，集合的长度 m、n 可能很大。

对于频繁使用 adjoin-set 的应用来说，可以采用允许重复元素的集合；
对于频繁使用 element-of-set?、union-set、intersection-set 的应用来说，
应该倾向于不允许重复元素的集合。
||#