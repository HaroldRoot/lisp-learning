;;;; 2.4.3 数据导向的程序设计和可加性

#||
检查一个数据项的类型，
并据此去调用某个适当过程称为
「基于类型的分派」
dispatching on type.
||#

#||
eg2.4.2_tagged_data.scm 的两大弱点：

（一）通用接口过程（ real-part 、 imag-part 、 magnitude 和 angle ）
必须了解所有不同的表示形式。例如，假设我们想要将复数的新表示形式合并到我们的
复数系统中。我们需要用新的类型来标识这个新的表示，然后向每个通用接口过程添加
一个子句来检查新类型，并为该表示应用适当的选择函数。

（二）即使可以单独设计各个表示，我们也必须保证整个系统中没有两个过程具有相同的名称。
这就是为什么 Ben 和 Alyssa 必须从 2.4.1 开始更改其原始程序的名称。
||#

#||
这两个弱点背后的问题是
实现通用接口的技术不是
「可加的」 additive.
||#

#||
我们需要的是一种进一步模块化系统设计的方法。
这是由称为「数据导向的程序设计」
data-directed programming
的编程技术提供的。
||#

#||
Ben 定义了一组过程，或者说一个「程序包」package，
并通过向表格中加入一些项的方式，
告诉系统如何去操作直角坐标形式表示的数。
||#

(define (install-rectangular-package)
  ;; 内部过程 internal procedures
  ;; 与当初 eg2.4.1_representations_for_complex_numbers.scm 独立写的一模一样
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) 
    (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  ;; 向系统其他部分提供的接口 interface to the rest of the system
  (define (tag x) 
    (attach-tag 'rectangular x))
  ;; (put <op> <type> <item>)
  ;; 将项<item>加入表格中，以<op>和<type>作为这个表项的索引  
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
  'done)

#||
Alyssa 的极座标包是类似的：
||#

(define (install-polar-package)
  ;; 内部过程 internal procedures
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  ;; 向系统其他部分提供的接口 interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (lambda (x y) 
         (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (lambda (r a) 
         (tag (make-from-mag-ang r a))))
  'done)

#||
尽管 Ben 和 Alyssa 仍然使用他们原来的过程，
其定义的名称与彼此相同（例如 real-part ），
但这些定义现在是不同过程的内部，
因此没有名称冲突。
||#

#||
复数算术的选择函数
通过称为 apply-generic 的
通用 “操作” 过程来访问表，
该过程将通用操​​作应用于某些参数。 

apply-generic 在表格中
查找操作名称和参数类型，
并应用结果过程（如果存在）：
||#

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types: 
             APPLY-GENERIC"
            (list op type-tags))))))

#||
利用 apply-generic，
各种通用型选择函数可以定义如下：
||#

(define (real-part z) 
  (apply-generic 'real-part z))
(define (imag-part z) 
  (apply-generic 'imag-part z))
(define (magnitude z) 
  (apply-generic 'magnitude z))
(define (angle z) 
  (apply-generic 'angle z))

;;; 构造函数

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 
        'rectangular) 
   x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 
        'polar) 
   r a))
