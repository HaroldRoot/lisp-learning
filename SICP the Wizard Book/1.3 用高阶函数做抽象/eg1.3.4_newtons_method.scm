#||
如果 x -> g(x) 是一个可微函数
那么方程 g(x)=0 的一个解就是函数 x -> f(x) 的一个不动点，
其中 f(x) = x - g(x)/g'(x)

导数不像平均阻尼，
导数是从函数到函数的一种变换，
例如，函数 x -> x^3 的导数
是另一个函数 x -> 3x^2

一般而言，如果 g 是一个函数
而 dx 是一个很小的数，
那么 g 的导数在任一数值 x 的值由下面函数给出：
g'(x) = (g(x+dx)-g(x)) / dx
||#

#|--------------------------------------------|#

;;; 计算 g'(x) = (g(x+dx)-g(x)) / dx

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
           dx)))

(define dx 0.00001)

(define (cube x) (* x x x))

((deriv cube) 5)
;Value: 75.00014999664018
; 将 x=5 代入 3x^2 准确值是 75

#|--------------------------------------------|#

;;; 计算 f(x) = x - g(x)/g'(x)

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

#|--------------------------------------------|#

;;; 寻找不动点的过程

(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        ;; 计算 f(guess) 的值，并将其赋给 next
        (let ((next (f guess)))
            ;; 如果 guess 和 next 的差的绝对值小于 tolerance，返回 next，否则递归调用 try 函数
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

#|--------------------------------------------|#

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

(define (sqrt x)
    (newtons-method (lambda (y) (- (square y) x))
                    1.0))

(sqrt 2)
;Value: 1.4142135623822438

#||
我晕了，捋一捋吧。

最开始：eg1.3.3_fixed_point.scm
目标：创建一个过程，它可以返回一个函数的不动点
不动点的基本定义：满足 f(x0)=x0 的值 x0 称为函数 f(x) 的不动点
创建名为 fixed-point 的过程：
    它接受一个过程参数 f，表示函数
    它接受一个数值参数 first-guess，表示初始猜测值
    它可以使用全局常量 tolerance
    它内部定义了一个 try 过程：
        不断计算 f(guess) 的值，并将其赋给 next
        如果 guess 和 next 的差的绝对值小于 tolerance，返回 next
        否则递归调用 try 过程，让 next 成为新的 guess
直观描述：
    不断迭代 f(first-guess), f(f(first-guess)), f(f(f(first-guess)))...
    f(f(f...f(first-guess)...)) 和上一次迭代相差小于 tolerance 了吗？
    是的话，就视为不动点已经找到了，它就是 f(f(f...f(first-guess)...))，直接返回它
应用：
    寻找 cos 函数的不动点：
        (fixed-point cos 1.0)
    找出方程 y = sin y + cos y 的一个解：
        即寻找函数 f(y) = sin y + cos y 的不动点：
            (fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)
出问题的地方：
    求一个数 x 的平方根：
        y^2 = x
        y = x/y
        即寻找函数 f(x) = x/y 的不动点：
            (fixed-point (lambda (y) (/ x y)) 1.0)
            它会不断利用猜测值 guess 计算出 x/guess
            直到下一次迭代和这次迭代相差小于 tolerance
    应用于求 2 的平方根：
        这一不动点搜寻并不收敛
        在答案的两边往复振荡
        f(1)=2，f(2)=1，f(1)=2...
    修改为寻找函数 f(x) = (y+(x/y))/2 的不动点：
        y = (y+(x/y))/2 移项后可化简得 y = x/y
        (fixed-point (lambda (y) (average y (/ x y))) 1.0)
        它会不断利用猜测值 guess 计算出 x/guess 和 guess 的平均值
        直到下一次迭代和这次迭代相差小于 tolerance



定义平均阻尼：eg1.3.4_average_damp.scm
回顾：
    √x 就是函数 y -> x/y 的不动点
    利用平均阻尼使这一逼近收敛
    平均阻尼是一种很有用的一般性技术
将平均阻尼的思想表述为过程：
    (define (average-damp f) (lambda (x) (average x (f x))))
    它接受一个函数参数 f
    返回一个匿名函数
        它接受一个数值参数 x
        返回 x 和 f(x) 的平均值
将寻找不动点的过程改为：
    (fixed-point (average-damp (lambda (y) (/ x y))) 1.0)
        它把函数 f(y)=x/y 作为参数传递给 average-damp 过程
        average-damp 过程返回一个匿名函数
            它接受一个数值参数 guess
            返回 guess 和 f(guess) 的平均值



现在的牛顿法：eg1.3.4_newtons_method.scm
在这个例子中，已知数 x，未知数 y，我们要求解的方程是 y^2 = x，也就是 y = sqrt(x)。
我们可以将这个方程转化为 y^2 - x = 0 的形式，然后使用牛顿迭代法求解。

牛顿迭代法的基本思想是：从一个初始值开始，通过不断迭代，逐渐接近方程的解。
在这个例子中，我们从 guess=1.0 开始，通过不断迭代，逐渐接近 sqrt(2) 的值。
具体来说，我们使用牛顿迭代公式：

next = guess - f(guess) / f'(guess)

其中，guess 是当前的迭代值，
f(guess) 是方程 guess^2 - x = 0，
f'(guess) 是 f(guess) 的导数。
在这个例子中，f(guess) = guess^2 - x，
f'(guess) = 2*guess。将这些值代入公式，我们可以得到：

next = guess - (guess^2 - x) / (2*guess)

其实化简可以得到：

next = (guess + x / guess) / 2

这就是代码中 newton-transform 函数的实现。
它接受一个函数 g(y)=y^2-x，其中已知数 x，未知数 y，
返回一个新的函数 f(y)=y-g(y)/g'(y) 。
然后，我们使用这个新函数和牛顿迭代公式，实现了求解方程的迭代过程。

最后，我们调用 sqrt 函数，传入参数 2，
就可以得到 1.4142135623730951，这是 2 的平方根的近似值。
||#