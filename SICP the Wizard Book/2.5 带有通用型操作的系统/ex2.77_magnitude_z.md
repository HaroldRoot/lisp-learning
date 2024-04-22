## 习题

**练习 2.77：** Louis Reasoner 尝试计算表达式 `(magnitude z)`，其中 `z` 是 `(cons 'complex (cons 'rectangular (cons 3 4)))`。令他惊讶的是，他没有得到答案 5，而是从 ` apply-generic ` 得到一个错误信息，说没有方法可以对类型 ` (complex) ` 进行操作 ` magnitude `。他向 Alyssa P. Hacker 展示了这个互动，Alyssa 说：“问题是复数选择器从未为 ` complex ` 数定义，只为 ` polar ` 和 ` rectangular ` 数定义。你所要做的就是将以下内容添加到 ` complex ` 包中：”

```scheme
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)
```

详细描述为什么这样做有效。例如，追踪在计算表达式 `(magnitude z)` 时调用的所有过程，其中 `z` 是 `(cons 'complex (cons 'rectangular (cons 3 4)))`。特别是，`apply-generic` 被调用了多少次？在每种情况下，分派了哪个过程？

## 解答

太久没看这本书了，好多东西我都忘了。先回顾一下。

### 带有类型标签的数据

在 *2.4.2 带标签的数据* 小节中，我们定义了三个过程，用于创建和操作带有类型标签的数据。

- `attach-tag` 过程接受两个参数：`type-tag` 和 `contents`。它使用 `cons` 过程将 `type-tag` 作为头部（car）和 `contents` 作为尾部（cdr）组合成一个新的 pair（序对）。这样，创建了一个带有类型标签的数据结构。
- `type-tag` 过程检查 `datum` 是否为一个 pair。如果是，它返回这个 pair 的头部（car），即之前附加的类型标签。如果 `datum` 不是一个 pair，它会触发一个错误，提示 “Bad tagged datum: TYPE-TAG”。
- `contents` 过程也检查 `datum` 是否为一个 pair。如果是，它返回这个 pair 的尾部（cdr），即数据的内容部分。如果 `datum` 不是一个 pair，它会触发一个错误，提示 “Bad tagged datum: CONTENTS”。

```scheme
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: 
              TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: 
              CONTENTS" datum)))
```

### “操作-类型”表（operation-and-type table）

在 *2.4.3 数据导向编程和可加性* 小节中，我们假设存在一张**表**，表中的条目是针对每种**参数类型**执行每种**操作**的**过程**。

假设我们有两个过程 `put` 和 `get`，用于操作这张表：

- `(put ⟨op⟩ ⟨type⟩ ⟨item⟩)` 
	- 在表中安装 `⟨item⟩`，由 `⟨op⟩` 和 `⟨type⟩` 作为索引。
- `(get ⟨op⟩ ⟨type⟩)`
	- 在表中查找对参数类型 `⟨type⟩` 执行操作 `⟨op⟩` 的过程。
	- 如果未找到任何条目，则返回 false。

我们假设 `put` 和 `get` 包含在我们的语言中，到第 3 章才会去实现。

### 安装直角坐标形式包

Ben 编写了一个用于安装直角坐标形式（rectangular）的复数包的过程。通过调用这个过程，你可以将直角坐标形式的复数操作添加到你的程序中：

1. 首先，定义了一些**内部过程**，这些过程将用于实现直角坐标形式的复数：
    - `(real-part z)`：返回复数 `z` 的实部。
    - `(imag-part z)`：返回复数 `z` 的虚部。
    - `(make-from-real-imag x y)`：根据给定的实部 `x` 和虚部 `y` 创建一个复数。
    - `(magnitude z)`：计算复数 `z` 的模（magnitude），即复数的长度。
    - `(angle z)`：计算复数 `z` 的幅角（angle）。
2. 接下来，定义了一些**接口过程**，用于与系统的其他部分交互：
    - `(tag x)`：将给定的数据 `x` 附加上类型标签 `'rectangular`，以表示这是一个直角坐标形式的复数。
    - `(put 'real-part '(rectangular) real-part)`：将 `'real-part` 这个操作与类型标签 `'rectangular` 关联起来，以便后续可以通过类型标签来调用实际的实部操作。
    - 同样地，将其他操作如虚部、模和幅角与类型标签关联起来。
3. 最后，返回 `'done`，表示安装直角坐标形式的复数包已经完成。

```scheme
(define (install-rectangular-package)
  ;; internal procedures
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
  ;; interface to the rest of the system
  (define (tag x) 
    (attach-tag 'rectangular x))
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
```

为什么是 `(put 'real-part '(rectangular) real-part)` 而不是 `(put 'real-part 'rectangular real-part)`？

为了保持系统在处理类型时的**一致性**。这里的疑惑会在这篇笔记最后得到解答。

### 通用操作过程

复数运算选择器通过名为 `apply-generic` 的通用“操作”过程访问表格，该过程将通用操作应用于某些参数。`apply-generic` 会根据操作名称和参数类型在表中查找，如果存在，则应用查找到的过程：

```scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types: 
             APPLY-GENERIC"
            (list op type-tags))))))
```

1. 首先，`apply-generic` 接受一个操作符 `op` 和一系列参数 `args`。
2. 然后，它使用 `map` 过程将参数的类型标签提取出来，存储在 `type-tags` 中。这样，我们可以知道每个参数的类型。
3. 接下来，它尝试从已注册的操作中获取与给定操作符和类型标签匹配的过程。这里使用了 `(get op type-tags)`，其中 `op` 是操作符，`type-tags` 是参数的类型标签列表。
4. 如果找到了匹配的过程（即 `proc` 不为空），则使用 `apply` 调用该过程，并将参数的内容传递给它。这样，我们可以执行不同类型的操作。
5. 如果没有找到匹配的过程，它会触发一个错误，提示 “No method for these types: APPLY-GENERIC”，并显示操作符和类型标签的列表。

总的来说，`apply-generic` 是一个用于多态系统中的通用操作调用过程。它根据参数的类型标签查找相应的操作，并执行该操作。如果找不到匹配的操作，它会报错。这种设计允许我们在不同类型之间共享相同的操作，从而实现多态性。

`apply-generic` 还使用原始过程 `apply` ，它接受两个参数：一个过程和一个列表。 `apply` 使用列表中的元素作为参数来应用该过程。例如，`(apply + (list 1 2 3 4))` 返回 10。

使用 `apply-generic` ，我们可以定义通用选择器，如下所示：

```scheme
(define (real-part z) 
  (apply-generic 'real-part z))
(define (imag-part z) 
  (apply-generic 'imag-part z))
(define (magnitude z) 
  (apply-generic 'magnitude z))
(define (angle z) 
  (apply-generic 'angle z))
```

### 安装复数包

定义了一个名为 `install-complex-package` 的过程，用于安装复数系统中的直角坐标形式（rectangular）和极坐标形式（polar）的复数包：

1. 首先，它导入了来自直角坐标形式和极坐标形式包的一些过程。
2. 然后，定义了一些**内部过程**，这些过程将用于实现复数的基本操作：
    - `(make-from-real-imag x y)`：根据给定的实部 `x` 和虚部 `y` 创建一个复数。它通过调用**直角坐标形式包**中的 `make-from-real-imag` 过程来实现。
    - `(make-from-mag-ang r a)`：根据给定的模 `r` 和幅角 `a` 创建一个复数。它通过调用**极坐标形式包**中的 `make-from-mag-ang` 过程来实现。
    - 其他内部过程 `add-complex`、`sub-complex`、`mul-complex` 和 `div-complex` 分别实现了复数的加法、减法、乘法和除法。
3. 接下来，定义了一些**接口函数**，用于与系统的其他部分交互：
    - `(tag z)`：将给定的数据 `z` 附加上类型标签 `'complex`，以表示这是一个复数。
    - 将复数操作与类型标签 `'complex` 关联起来，使得可以通过类型标签来调用实际的操作。
4. 最后，返回 `'done`，表示安装复数包已经完成。

这段代码的目的是为了创建一个复数系统，其中可以使用直角坐标形式和极坐标形式来表示和操作复数。通过这些操作，你可以执行复数的加法、减法、乘法和除法，以及创建不同形式的复数。这种抽象数据类型的设计允许你在程序中更方便地处理复数。

```scheme
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))
```

在复数包之外的程序可以通过实部和虚部或模和幅角来构造复数。请注意，最初在直角坐标形式和极坐标形式包中定义的底层过程被导出到复数包中，然后又从复数包被导出到外部世界。

“**导出**”意味着直角坐标形式和极坐标形式包中定义的过程被复数包使用，并且复数包允许这些过程可以被其他不属于这个包的代码所调用。这样，外部程序就可以利用这些过程来创建和操作复数，而不需要直接与直角坐标形式和极坐标形式包打交道。这种设计模式提高了代码的可重用性和模块化，使得不同的程序部分可以更加独立地开发和维护。

### 最后来看习题

在采纳 Alyssa 的建议之前：

```scheme
(magnitude z) ; 向外部世界暴露的通用选择器
(apply-generic 'magnitude z)
(apply-generic 'magnitude (cons 'complex (cons 'rectangular (cons 3 4))))
```

首先，`apply-generic` 被调用，以查找与操作 `magnitude` 和类型标签 `complex` 相匹配的过程。

`apply-generic` 使用 `type-tags` 来确定参数的类型标签。在这里，`type-tags` 是 `'(complex)`。（注意！这就是为什么之前向表注册过程的时候用的是 `(put 'real-part '(rectangular) real-part)`，为了保持系统的**一致性**！）

接下来，它尝试从已注册的操作中获取与操作符和类型标签匹配的过程。在这里，它查找 `magnitude` 操作与类型标签 `complex` 相关联的过程。

但是因为复数包中并未为 `complex` 类型定义 `magnitude` 选择器，所以会报错。

根据 Alyssa 的建议，我们添加了以下内容到 `complex` 包中：

- `(put 'real-part '(complex) real-part)`
- `(put 'imag-part '(complex) imag-part)`
- `(put 'magnitude '(complex) magnitude)`
- `(put 'angle '(complex) angle)`

现在，`apply-generic` 找到了与 `magnitude` 操作和类型标签 `complex` 相匹配的过程。它将**再一次**调用 `magnitude` 过程。

所以整个流程如下：

```scheme
(magnitude z) ; 向外部世界暴露的通用选择器
(apply-generic 'magnitude z)
(apply-generic 'magnitude (cons 'complex (cons 'rectangular (cons 3 4))))
;; 查表，找到对应的过程是向外部世界暴露的 magnitude
(magnitude (cons 'rectangular (cons 3 4)))
(apply-generic 'magnitude (cons 'rectangular (cons 3 4)))
;; 查表，找到对应的过程是直角坐标形式包的内部过程 magnitude
(sqrt (+ (square (real-part (cons 3 4)))
         (square (imag-part (cons 3 4)))))
```

`apply-generic` 被调用了 2 次。

第一次分派了向外部世界暴露的通用选择器 `magnitude`：

```scheme
(define (magnitude z) 
  (apply-generic 'magnitude z))
```

第二次分派了直角坐标形式包的内部过程 `magnitude`：

```scheme
(define (install-rectangular-package)
  ;; internal procedures...
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  ;; interface to the rest of the system...
  (put 'magnitude '(rectangular) magnitude)
  'done)
```

