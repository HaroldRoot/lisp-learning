#||
e - 2 = (cont-frac n d k)
n = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...]
d = [1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...]
||#

(define (cont-frac-iter n d k)
    (define (iter i result)
        (if (= i 0)
            result
            (iter (-1+ i)
                  (/ (n i)
                     (+ (d i) result)))))
    (iter (-1+ k)
          (/ (n k) (d k))))

(define (n i) 1.0)

(define (d i)
    (cond ((= (remainder i 3) 2)
           (* 2.0 (/ (+ i 1) 3)))
          (else 1.0)))

(define (e k)
    (+ 2 (cont-frac-iter n d k)))

(e 1)
;Value: 3.

(e 2)
;Value: 2.6666666666666665

(e 10)
;Value: 2.7182817182817183

(e 67)
;Value: 2.7182818284590455