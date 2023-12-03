;;;; 练习 2.73

#||
/2.3 符号数据/eg2.3.2_symbolic_differentiation.scm

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        <更多规则可以加在这里>
        (else (error "unknown expression 
                      type: DERIV" exp))))
||#

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) 
         (if (same-variable? exp var) 
             1 
             0))
        (else ((get 'deriv (operator exp)) 
               (operands exp) 
               var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

#|---------------------------------------------------|#

;;; a)

#||
f(var) = exp
(deriv exp var) = f'(var)
对函数 f(var) = exp 进行求导

如果表达式 exp 是常数，结果为 0；
如果表达式 exp 是单个变量，
就判断 exp 和 var 是不是同一个变量，
如果是，结果为 1，如果不是，结果为 0；
否则，(get <op> <type>)
在表中查找与<op>和<type>对应的项，
如果找到就返回找到的项，否则就返回假。

(get 'deriv (operator exp)) 
就是在表中查找对 exp 的类型进行 deriv 操作的过程<item>，
exp 的类型用 exp 的运算符 operator 表示，
随后将这一过程<item>应用到 exp 的运算对象 operands 上，
这一过程<item>应该接收两个参数，即 (operands exp) 和 var

表格：

|↓操作<op>\数据类型<type>→ | +          | *          |
|------------------------|------------|------------|
|    deriv               | procedure1 | procedure2 |

如果 exp 是常数或者单个变量，那它就是 '(0) 或者 '(x)' 之类的，
它不像加式 '(+ 3 x) 或者乘式 '(* 3 x) 一样有前缀 operator
来表示它的类型 <type>，所以不能加入数据导向分派中。
||#

#|---------------------------------------------------|#

;;; b)
;;; c)
;;; 见 ex2.73_(runnable)_deriv.rkt

#|---------------------------------------------------|#

;;; d)

#||
如果使用 ((get (operator exp) 'deriv) (operands exp) var)
而非 ((get 'deriv (operator exp)) (operands exp) var)

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) 
         (if (same-variable? exp var) 
             1 
             0))
        ;; 下面一行对调了 get 函数中第一和第二参数的位置
        (else ((get 'deriv (operator exp)) 
               (operands exp) 
               var))))
;; 我们还必须调换 package 安装函数中 put 调用的参数顺序
;; 必须吗？只要改变 get 过程定义时的形参列表就好了吧
||#

