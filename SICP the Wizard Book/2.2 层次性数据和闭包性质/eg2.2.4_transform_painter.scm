;;; 框架坐标映射
;;; 将向量 v(x,y) 映射到 Origin(Frame) + x·Edge_1(Frame) + y·Edge_2(Frame)
;;; 其中 0 <= x,y <= 1
(define (frame-coord-map frame)
    (lambda (v)
        (add-vect
            (origin-frame frame)
            (add-vect (scale-vect (xcor-vect v)
                                  (edge1-frame frame))
                      (scale-vect (ycor-vect v)
                                  (edge2-frame frame))))))

;;; 画家

#||
一个画家 painter 被表示为一个过程
给了它一个框架 frame 作为实际参数
它就能通过适当的位移和伸缩，画出一幅与这个框架匹配的画像

任何过程只要能取一个框架作为参数
画出某些可以伸缩后适合这个框架的东西
它就可以作为一个画家
||#

;;; 下面的过程可以接收一个 线段表，返回一个 画家
(define (segments->painter segment-list)
    (lambda (frame)
        (for-each
            (lambda (segment)
                (draw-line
                    ((frame-coord-map frame) (start-segment segment))
                    ((frame-coord-map frame) (end-segment segment))))
            (segment-list))))

;;; 画家的变换和组合

#||
origin，corner1 和 corner2 都是向量（或者说单位正方形中的点）
new-origin
= (m origin)
= ((frame-coord-map frame) origin)
= Origin(Frame) + (xcor-vect origin)·Edge_1(Frame) + (ycor-vect origin)·Edge_2(Frame)
||#

(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter
                    (make-frame new-origin
                                (sub-vect (m corner1) new-origin)
                                (sub-vect (m corner2) new-origin)))))))

;;; 定义反转画家
(define (flip-vert painter)
    (transform-painter painter
                       (make-vect 0.0 1.0)   ; 新的原点
                       (make-vect 1.0 1.0)   ; 新的 edge1 的终点
                       (make-vect 0.0 0.0))) ; 新的 edge2 的终点

;;; 逆时针方形旋转 90 度
(define (rotate90 painter)
    (transform-painter painter
                       (make-vect 1.0 0.0)   ; 新的原点
                       (make-vect 1.0 1.0)   ; 新的 edge1 的终点
                       (make-vect 0.0 0.0))) ; 新的 edge2 的终点

;;; 向中心收缩
(define (squash-inwards painter)
    (transform-painter painter
                       (make-vect 0.0 0.0)   ; 新的原点
                       (make-vect 0.65 0.35)   ; 新的 edge1 的终点
                       (make-vect 0.35 0.65))) ; 新的 edge2 的终点

;;; 产生一个新的复合型画家
(define (beside painter1 painter2)
    (let ((split-point (make-vect 0.5 0.0)))
        (let ((paint-left
                (transform-painter painter1
                                   (make-vect 0.0 0.0)
                                   split-point
                                   (make-vect 0.0 1.0)))
              (paint-right
                (transform-painter painter2
                                   split-point
                                   (make-vect 1.0 0.0)
                                   (make-vect 0.5 1.0))))
             (lambda (frame)
                (paint-left frame)
                (paint-right frame)))))