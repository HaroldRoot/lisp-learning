(define (install-scheme-number-package) 
  ;; ... 
  (put '=zero? 'scheme-number
       (lambda(x)
         (= 0 x)))
  'done)

(define (install-rational-package) 
  ;; ... 
  (put '=zero? 'rational
       (lambda(x)
         (= 0 (numer x))))
  'done) 

(define (install-complex-package)   
  ;; ... 
  (put '=zero? 'complex 
       (lambda (x)
         (and (= 0 (real-part x))
              (= 0 (imag-part x)))))
  'done)

(define (=zero? x)
  (apply-generic '=zero? x)) 