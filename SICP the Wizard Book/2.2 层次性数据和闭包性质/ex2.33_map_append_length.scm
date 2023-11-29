;;;; 完成将一些基本的表操作看作累积的定义

;;; eg2.2.3_signal_flow.scm
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))
    
(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y))
                '()
                sequence))

;;; 测试 map
(map square (list 1 2 3))
;Value: (1 4 9)

(define (append sq1 sq2)
    (accumulate cons
                sq2
                sq1))

;;; 测试 append
(define x (list 1 2 3))

(define y (list 4 5 6))

(append x y)
;Value: (1 2 3 4 5 6)

(define (length sequence)
    (accumulate (lambda (x y) (+ 1 y))
                0
                sequence))

;;; 测试 length
(length x)
;Value: 3