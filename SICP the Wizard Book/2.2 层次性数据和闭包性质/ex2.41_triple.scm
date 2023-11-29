;;; 1 <= k < j < i <= n
;;; i + j + k = s

(load "SICP the Wizard Book/2.2 层次性数据和闭包性质/eg2.2.3_prime_sum_pairs.scm")
; 需要 flatmap，enumerate-interval

(define (unique-pairs n)
    (flatmap (lambda (i) 
                     (map (lambda (j) (list i j))
                          (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))

(define (unique-triples n)
    (flatmap (lambda (i) 
                     (flatmap (lambda (j)
                                      (map (lambda (k) (list k j i))
                                           (enumerate-interval 1 (- j 1))))
                              (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))

(unique-triples 6)
;Value: ((1 2 3) (1 2 4) (1 3 4) (2 3 4) (1 2 5) 
; (1 3 5) (2 3 5) (1 4 5) (2 4 5) (3 4 5) (1 2 6) 
; (1 3 6) (2 3 6) (1 4 6) (2 4 6) (3 4 6) (1 5 6) 
; (2 5 6) (3 5 6) (4 5 6))

(define (special-triples n s)
    (filter (lambda (x) (= s (+ (car x) (cadr x) (caddr x))))
            (unique-triples n)))

(special-triples 6 11)
;Value: ((2 4 5) (2 3 6) (1 4 6))