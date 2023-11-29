;;; 一个二叉活动体由两个分支组成
;;; 一个是左分支，另一个是右分支
(define (make-mobile left right)
    (list left right))

;;; 分支可以从一个 length 再加上一个 structure 构造出来
;;; 每个分支是一个具有确定长度 length 的杆
;;; 上面要么吊着一个重量，要么吊着另一个二叉活动体
;;; structure 要么是一个数，表示一个简单重量，要么是另一个活动体
(define (make-branch length structure)
    (list length structure))

#|------------------------------------------------------|#

;;; a)

(define left-branch car)

(define right-branch cadr)

(define branch-length car)

(define branch-structure cadr)

#|------------------------------------------------------|#

;;; b)

;;; 先写一下测试样例，方便试探
(define branch-1 (make-branch 3 4))

(define branch-3 (make-branch 6 7))

(define branch-2 (make-branch 2 branch-3))

(define my-mobile (make-mobile branch-1 branch-2))

my-mobile
;Value: ((3 4) (2 (6 7)))
; 需要的是 4+7=11
; 对所有的右叶子进行加和

(left-branch my-mobile)
;Value: (3 4)

(right-branch my-mobile)
;Value: (2 (6 7))
; 到这里的时候发现，right-branch 应该定义为 cadr 而不是 cdr
; 同样地，branch-structure 也应该定义为 cadr 而不是 cdr

(define (total-weight mobile)
    (+ (weight (left-branch mobile))
       (weight (right-branch mobile))))

(define (weight branch)
        (if (not (pair? (branch-structure branch)))
            (branch-structure branch)
            (weight (branch-structure branch))))

(total-weight my-mobile)
;Value: 11

#|------------------------------------------------------|#

;;; c)

(define (total-length branch)
    (define (iter result node)
        (if (pair? (branch-structure node))
            (iter (+ result (branch-length node)) (branch-structure node))
            (+ result (branch-length node))))
    (iter 0 branch))

(total-length (left-branch my-mobile))
;Value: 3

(total-length (right-branch my-mobile))
;Value: 8

(define (balanced? mobile)
    (= (* (total-length (left-branch mobile))
          (weight (left-branch mobile)))
       (* (total-length (right-branch mobile))
          (weight (right-branch mobile)))))

(balanced? my-mobile)
;Value: #f

;; 弄一个平衡的测试一下

(define branch-a (make-branch 6 7)) ; 6*7=42

(define branch-c (make-branch 7 3))

(define branch-b (make-branch 7 branch-c)) ; (7+7)*3=42

(define balanced-mobile (make-mobile branch-a branch-b))

(balanced? balanced-mobile)
;Value: #t

#|------------------------------------------------------|#

;;; d)

(define (make-mobile-cons left right)
    (cons left right))

(define (make-branch-cons length structure)
    (cons length structure))

;; 测试一下
(define branch-c1 (make-branch-cons 3 4))

(define branch-c3 (make-branch-cons 6 7))

(define branch-c2 (make-branch-cons 2 branch-c3))

(define mobile-c (make-mobile-cons branch-c1 branch-c2))

mobile-c
;Value: ((3 . 4) 2 6 . 7)

(car mobile-c)
;Value: (3 . 4)

(cdr mobile-c)
;Value: (2 6 . 7)

(cadr mobile-c)
;Value: 2

#||
my-mobile
;Value: ((3 4) (2 (6 7)))

(left-branch my-mobile) ; car
;Value: (3 4)

(right-branch my-mobile) ; cadr
;Value: (2 (6 7))

只要把 right-branch-cons 定义为 cdr 而不是 cadr 应该就行了
||#

(define left-branch-cons car)

(define right-branch-cons cdr)

(define branch-length-cons car)

(define branch-structure-cons cdr)

(define (total-weight-cons mobile)
    (+ (weight-cons (left-branch-cons mobile))
       (weight-cons (right-branch-cons mobile))))

(define (weight-cons branch)
        (if (not (pair? (branch-structure-cons branch)))
            (branch-structure-cons branch)
            (weight-cons (branch-structure-cons branch))))

(total-weight-cons mobile-c)
;Value: 11