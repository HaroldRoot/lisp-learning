(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/eg2.2.3_signal_flow.scm")
; 需要 enumerate-interval, accumulate, filter

(define (flatmap proc seq)
    (accumulate append '() (map proc seq)))

(define (unique-pairs n)
    (flatmap (lambda (i) 
                     (map (lambda (j) (list i j))
                          (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))

(unique-pairs 6)
;Value: ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3) (5 1) (5 2) (5 3) (5 4) (6 1) (6 2) (6 3) (6 4) (6 5))

(define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
    (map make-pair-sum
         (filter prime-sum? (unique-pairs 6))))

(load "SICP the Wizard Book/1.2 过程与它们所产生的计算/ex1.28_2_miller-rabin-nontrivial.scm")
; 引入 prime?

(prime-sum-pairs 6)
;Value: ((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 11))