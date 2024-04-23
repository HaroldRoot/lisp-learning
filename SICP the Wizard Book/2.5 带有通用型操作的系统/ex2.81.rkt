#lang sicp

;; a
; apply-generic 会在强制类型上递归调用自身,因此会进入无限递归。

;; b
; Louis 的代码无法起效。apply-generic 还是是会像原来那样进入无限递归。

;;c
(define (apply-generic op . args)
  (define (no-method type-tags)
    (error "No method for these types"
           (list op type-tags)))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (equal? type1 type2)
                    (no-method type-tags)
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                             (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                             (apply-generic op a1 (t2->t1 a2)))
                            (else (no-method type-tags))))))
              (no-method type-tags))))))