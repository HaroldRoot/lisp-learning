(define deriv
    (lambda (f)
        (lambda x)
            (/ (- (f (+ x dx))
                  (f x))
               dx)))
;;; deriv(f(x))=f'(x)=(f(x+dx)-f(x))/dx

(define dx 0.000001)