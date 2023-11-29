;;; eg2.2.3_signal_flow.scm
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                        (+ (* higher-terms x) this-coeff))
                0
                coefficient-sequence))

;;; 测试 1 + 3x + 5x^3 + x^5 在 x=2 的值
(horner-eval 2 (list 1 3 0 5 0 1))
;Value: 79
; 1 + 6 + 40 + 32 = 79