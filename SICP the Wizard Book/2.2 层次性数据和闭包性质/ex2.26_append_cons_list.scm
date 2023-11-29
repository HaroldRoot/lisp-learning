(define x (list 1 2 3))

(define y (list 4 5 6))

(append x y)
;Value: (1 2 3 4 5 6)

(cons x y)
;Value: ((1 2 3) 4 5 6)

(list x y)
;Value: ((1 2 3) (4 5 6))

#||
这是因为 append、cons 和 list 这三个 Scheme 内置函数的行为不同。

append 函数将两个列表连接成一个新的列表，
返回值是一个包含所有元素的新列表。
在这个例子中，(append x y) 的返回值是 (1 2 3 4 5 6)，
即将 x 和 y 中的元素合并成一个新的列表。

cons 函数将一个元素添加到一个列表的开头，返回值是一个新的列表。
在这个例子中，(cons x y) 的返回值是 ((1 2 3) 4 5 6)，
即将 x 作为一个元素添加到 y 的开头，形成一个新的列表。

list 函数将所有参数组合成一个新的列表，返回值是一个新的列表。
在这个例子中，(list x y) 的返回值是 ((1 2 3) (4 5 6))，
即将 x 和 y 作为两个元素组合成一个新的列表。
||#

(define z (list 4 5 (list 6 7)))

(append x z)
;Value: (1 2 3 4 5 (6 7))

(cons x z)
;Value: ((1 2 3) 4 5 (6 7))

(list x z)
;Value: ((1 2 3) (4 5 (6 7)))