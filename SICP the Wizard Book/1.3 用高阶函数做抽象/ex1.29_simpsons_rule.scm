;;;; 练习1.29 辛普森规则

(define (cube x) (* x x x))

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a)
           (sum term (next a) next b))))

(define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(integral cube 0 1 0.01) ; .24998750000000042

(integral cube 0 1 0.001) ; .249999875000001

#|--------------------------------------------|#

(define (simpson f a b n)
    (define h 
        (/ (- b a) n))
    (define (simpson-term k)
        (let ((yk (f (+ a (* k h)))))
            (cond ((= k 0) yk)
                  ((= k n) yk)
                  ((even? k) (* 2 yk))
                  ((odd? k) (* 4 yk)))))
    (* (/ h 3.0) (sum simpson-term 0 1+ n)))

(simpson cube 0 1 100) ; .25

(simpson cube 0 1 1000) ; .25