#||
实现矩形的两种表示方式
提供适当的抽象屏障
使同一个周长或面积过程对两种不同表示都能工作
||#

;;; Wishful Thinking

(define (perim r) ; 计算周长过程，接受一个矩形作为参数
    (* 2 (+ (rect-len r)
            (rect-wid r))))

(define (area r) ; 计算面积过程，接受一个矩形作为参数
    (* (rect-len r)
       (rect-wid r)))

#|------------------------------------------------|#

;;; ex2.2_print_point.scm

(define make-point cons)

(define x-point car)

(define y-point cdr)

(define make-segment cons)

(define start-segment car)

(define end-segment cdr)

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")"))

#|------------------------------------------------|#

;;; 第一种矩形表达方式
;;; 使用 4 条 segment 表示矩形
;;; 虽然这样会保存重复的点诶

(define (make-rect l1 l2 w1 w2)
    (cons (cons l1 l2)
          (cons w1 w2)))

(define (rect-l1 r)
    (if (number? (car (car (car r)))) ; 对两种矩形表达方式进行兼容！
        (car r)
        (car (car r))))

(define (rect-l2 r)
    (cdr (car r)))

(define (rect-w1 r)
    (if (number? (car (car (cdr r)))) ; 对两种矩形表达方式进行兼容！
        (cdr r)
        (car (cdr r))))

(define (rect-w2 r)
    (cdr (cdr r)))

;;; 测试----------------------------------------------

(define l1 (make-segment (make-point 1 7)
                         (make-point 6 7)))
                         
(define l2 (make-segment (make-point 1 1)
                         (make-point 6 1)))

(define w1 (make-segment (make-point 1 1)
                         (make-point 1 7)))

(define w2 (make-segment (make-point 6 1)
                         (make-point 6 7)))

(define rect (make-rect l1 l2 w1 w2))

rect
;Value: ((((1 . 7) 6 . 7) (1 . 1) 6 . 1) ((1 . 1) 1 . 7) (6 . 1) 6 . 7)

(rect-l1 rect)
;Value: ((1 . 7) 6 . 7)

(rect-w1 rect)
;Value: ((1 . 1) 1 . 7)

;;; 打印矩形-------------------------------------------

(define (print-rect r)
    (let ((l1 (rect-l1 r))
          (l2 (rect-l2 r))
          (w1 (rect-w1 r))
          (w2 (rect-w2 r)))
        (newline)
        (display "L1:")
        (print-point (start-segment l1))
        (print-point (end-segment l1))
        (newline)
        (display "L2:")
        (print-point (start-segment l2))
        (print-point (end-segment l2))
        (newline)
        (display "W1:")
        (print-point (start-segment w1))
        (print-point (end-segment w1))
        (newline)
        (display "W2:")
        (print-point (start-segment w2))
        (print-point (end-segment w2))))

(print-rect rect)
#||
L1:
(1,7)
(6,7)
L2:
(1,1)
(6,1)
W1:
(1,1)
(1,7)
W2:
(6,1)
(6,7)
||#

;;; 定义矩形的长和宽------------------------------------

(define (rect-len r)
    (abs (- (x-point (start-segment (rect-l1 r)))
            (x-point (end-segment (rect-l1 r))))))

(define (rect-wid r)
    (abs (- (y-point (start-segment (rect-w1 r)))
            (y-point (end-segment (rect-w1 r))))))

(rect-len rect)
;Value: 5

(rect-wid rect)
;Value: 6

#|------------------------------------------------|#
#|------------------------------------------------|#
#|------------------------------------------------|#

;;; 第二种矩形表达方式
;;; 使用 2 条 segment 表示矩形

(define (new-make-rect l w)
    (cons l w))

(define (new-rect-l r)
    (car r))

(define (new-rect-w r)
    (cdr r))

(define l (make-segment (make-point 1 7)
                        (make-point 6 7)))

(define w (make-segment (make-point 1 1)
                        (make-point 1 7)))

(define new-r (new-make-rect l w))

new-r
;Value: (((1 . 7) 6 . 7) (1 . 1) 1 . 7)

(car new-r)
;Value: ((1 . 7) 6 . 7)

(car (car new-r))
;Value: (1 . 7)

(car (car (car new-r)))
;Value: 1

; (car (car (car (car new-r))))
;The object 1, passed as the first argument to car, is not the correct type.

(cdr new-r)
;Value: ((1 . 1) 1 . 7)

(rect-l1 new-r)
;Value: ((1 . 7) 6 . 7)

(rect-w1 new-r)
;Value: ((1 . 1) 1 . 7)

#|------------------------------------------------|#
#|------------------------------------------------|#
#|------------------------------------------------|#

(perim rect)
;Value: 22

(area rect)
;Value: 30

(perim new-r)
;Value: 22

(area new-r)
;Value: 30