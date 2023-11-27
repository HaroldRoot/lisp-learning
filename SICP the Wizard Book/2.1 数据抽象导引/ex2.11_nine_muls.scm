(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (max (car x) (cdr x)))

(define (lower-bound x)
    (min (car x) (cdr x)))

(define (old-mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))

#|---------------------------------------------------|#

;;; 区间整体小于 0，整体大于 0，横跨 0
;;; 3*3=9 种情况

(define mi make-interval)

(define ub upper-bound)

(define lb lower-bound)

(define (mul-interval x y)
    (define lx (lb x))
    (define ux (ub x))
    (define ly (lb y))
    (define uy (ub y))
    (cond ((< ux 0)
            (cond ((< (ub y) 0) ; x<0, y<0
                    (mi (* ux uy) (* lx ly)))
                  ((> (lb y) 0) ; x<0, y>0
                    (mi (* lx uy) (* ux ly)))
                  (else ; x<0, y 横跨 0
                    (mi (* lx uy) (* lx ly)))))
          ((> (lb x) 0)
            (cond ((< (ub y) 0) ; x>0, y<0
                    (mi (* ux ly) (* lx uy)))
                  ((> (lb y) 0) ; x>0, y>0
                    (mi (* lx ly) (* ux uy)))
                  (else  ; x>0, y 横跨 0
                    (mi (* ux ly) (* ux uy))))) 
          (else
            (cond ((< (ub y) 0) ; x 横跨 0, y<0
                    (mi (* ux ly) (* lx ly)))
                  ((> (lb y) 0) ; x 横跨 0, y>0
                    (mi (* lx uy) (* ux uy)))
                  (else ; x 横跨 0, y 横跨 0
                    (let ((p1 (* lx ly)) 
                          (p2 (* lx uy)) 
                          (p3 (* ux ly)) 
                          (p4 (* ux uy))) 
                        (mi (min p1 p2 p3 p4) 
                            (max p1 p2 p3 p4))))))))

#|---------------------------------------------------|#

;;; 测试用的过程

(define (eq-interval? a b) 
    (and (= (ub a) (ub b)) 
         (= (lb a) (lb b)))) 

(define (ensure-mult-works ah al bh bl)
    (let ((a (mi al ah))
          (b (mi bl bh)))
        (if (eq-interval? (old-mul-interval a b)
                          (mul-interval a b))
            #t
            (error "New mul returns different result!"
                   a
                   b
                   (old-mul-interval a b)
                   (mul-interval a b)))))

#|---------------------------------------------------|#

;;; 测试

(ensure-mult-works  +10 +10   +10 +10) 
(ensure-mult-works  +10 +10   +00 +10) 
(ensure-mult-works  +10 +10   +00 +00) 
(ensure-mult-works  +10 +10   +10 -10) 
(ensure-mult-works  +10 +10   -10 +00) 
(ensure-mult-works  +10 +10   -10 -10) 

(ensure-mult-works  +00 +10   +10 +10) 
(ensure-mult-works  +00 +10   +00 +10) 
(ensure-mult-works  +00 +10   +00 +00) 
(ensure-mult-works  +00 +10   +10 -10) 
(ensure-mult-works  +00 +10   -10 +00) 
(ensure-mult-works  +00 +10   -10 -10) 

(ensure-mult-works  +00 +00   +10 +10) 
(ensure-mult-works  +00 +00   +00 +10) 
(ensure-mult-works  +00 +00   +00 +00) 
(ensure-mult-works  +00 +00   +10 -10) 
(ensure-mult-works  +00 +00   -10 +00) 
(ensure-mult-works  +00 +00   -10 -10) 

(ensure-mult-works  +10 -10   +10 +10) 
(ensure-mult-works  +10 -10   +00 +10) 
(ensure-mult-works  +10 -10   +00 +00) 
(ensure-mult-works  +10 -10   +10 -10) 
(ensure-mult-works  +10 -10   -10 +00) 
(ensure-mult-works  +10 -10   -10 -10) 

(ensure-mult-works  -10 +00   +10 +10) 
(ensure-mult-works  -10 +00   +00 +10) 
(ensure-mult-works  -10 +00   +00 +00) 
(ensure-mult-works  -10 +00   +10 -10) 
(ensure-mult-works  -10 +00   -10 +00) 
(ensure-mult-works  -10 +00   -10 -10) 

(ensure-mult-works  -10 -10   +10 +10) 
(ensure-mult-works  -10 -10   +00 +10) 
(ensure-mult-works  -10 -10   +00 +00) 
(ensure-mult-works  -10 -10   +10 -10) 
(ensure-mult-works  -10 -10   -10 +00) 

;;; 全 #t，没报错！