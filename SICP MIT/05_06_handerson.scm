(define (coord-map rect) ; 以一个矩阵为参数
    (lambda (point)
        (+vect 
            (+vect (scale (xcor point)
                          (horiz rect)) ; 缩放水平坐标
                   (scale (ycor point)
                           (vert rect))) ; 缩放竖直坐标
        (origin rect)))) ; 返回一个过程
#||
快速理解为：不同的 rect 生成不同的 coord-map，
以后的用法就是 ((coord-map certain-rect) any-point)

定义了一个名为 coord-map 的函数，
它接受一个矩形作为参数，返回一个映射函数。
    该映射函数可以将一个点的坐标
    转换为矩形的坐标系中的对应点。

使用 lambda 表达式创建了一个匿名函数，
它有一个参数 point，表示一个点。

使用 scale 函数
将 point 的横纵坐标
分别乘以矩形的水平和垂直方向的长度，
得到到一个新的向量。

使用 +vect 函数
将这个新的向量和矩形的原点相加，
得到一个最终的向量，
它表示 point 在矩形坐标系中的位置。

返回这个最终的向量作为映射函数的结果。
||#

;;; Constructing Primitive Pictures from Lists of Segments
;;; 由线段列表构建基本图像
(define (make-picture seglist)
    (lambda (rect)
        (for-each 
            (lambda (s)
                (drawline
                    ((coord-map rect) (seg-start s))
                    ((coord-map rect) (seg-end s))))
        seglist)))
#||
快速理解为：不同的 seglist 生成不同的 make-picture，
以后的用法就是 ((make-picture certain-seglist) any-rect)

定义了一个名为 make-picture 的函数，
它有一个参数 seglist，表示一个线段列表。

使用 lambda 表达式创建了一个匿名函数，
它有一个参数 rect，表示一个矩形区域。

使用 for-each 函数遍历 seglist 中的每个线段 s。

对于每个线段 s，调用之前定义的 coord-map 函数，
将线段的起点和终点分别转换为矩形坐标系中的对应点。

调用预定义的 drawline 函数，根据这两个点绘制一条直线。

返回这个绘图函数作为make-picture函数的结果。
||#

(define (beside p1 p2 a)
    (lambda (rect)
        (p1 (make-rect
                (origin rect)
                (scale a (horiz rect))
                (vert rect)))
        (p2 (make-rect
                (+vect (origin rect)
                       (scale a (horiz rect)))
                (scale (- 1 a) (horiz rect))
                (vert rect)))))

(define (rotate90 pict)
    (lambda (rect)
        (pict (make-rect
                (+vect (origin rect)
                       (horiz rect))
                (vert rect)
                (scale -1 (horiz rect))))))

(define (right-push p n a)
    (if (= n 0)
        p
        (beside p 
                (right-push p
                            (- n 1)
                            a)
                a)))

(define (push comb)
    (lambda (pict n a)
        ((repeated
            (lambda (p) (comb pict p a))
            n)
        pict)))


(define right-push (push beside))