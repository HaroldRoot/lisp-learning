# 练习 2.64（第 108 页）

## 代码

```scheme
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree 
        elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0) ; 如果 n 等于 0，说明不需要构造树
      (cons '() elts) ; 返回一个序对，car 是空表，cdr 是原始表
      (let ((left-size 
             (quotient (- n 1) 2))) ; 否则，计算左子树的大小，为 (n-1)/2
        (let ((left-result 
               (partial-tree 
                elts left-size))) ; 递归地调用 partial-tree 函数，构造左子树，返回一个序对，car 是左子树，cdr 是剩余的元素表
          (let ((left-tree 
                 (car left-result)) ; 取出左子树
                (non-left-elts 
                 (cdr left-result)) ; 取出剩余的元素表
                (right-size 
                 (- n (+ left-size 1)))) ; 计算右子树的大小，为 n - (left-size + 1)
            (let ((this-entry 
                   (car non-left-elts)) ; 取出剩余元素表的第一个元素，作为根节点
                  (right-result 
                   (partial-tree 
                    (cdr non-left-elts)
                    right-size))) ; 递归地调用 partial-tree 函数，构造右子树，返回一个序对，car 是右子树，cdr 是剩余的元素表
              (let ((right-tree 
                     (car right-result)) ; 取出右子树
                    (remaining-elts 
                     (cdr right-result))) ; 取出剩余的元素表
                (cons (make-tree this-entry 
                                 left-tree 
                                 right-tree) ; 使用 make-tree 函数，根据根节点、左子树和右子树构造一棵树
                      remaining-elts)))))))) ; 返回一个序对，car 是构造出的树，cdr 是剩余的元素表
```

## 时间复杂度分析

在每一步，`partial-tree` 将一个长度为 $n$ 的表分成两个长度大约为 $n÷2$ 的表。

分割表的工作是 `(quotient (- n 1) 2)` 和 `(- n (+ left-size 1))`，这两个都是常数时间的操作。

合并结果的工作是 `(make-tree this-entry left-tree right-tree)`，也是常数时间的操作。

因此，构造一个包含 $n$ 个元素的表的部分树的时间是：

$T(n)=2T(n÷2)+Θ(1)$

根据[主定理](https://zh.wikipedia.org/wiki/%E4%B8%BB%E5%AE%9A%E7%90%86)，我们有 $a=2$ ， $b=2$ ，和 $f(n)=Θ(1)$  。因此， $T(n)=Θ(n)$ 。

`list->tree` 对一个长度为 n 的表所花的时间是 `partial-tree` 和 `length` 对那个表所花的时间之和。这两个过程的增长阶都是 $Θ(n)$，所以 `list->tree` 的增长阶也是 $Θ(n)$。

## 主定理

假设有递归关系式

$$
{\displaystyle T(n)=a\;T\!\left({\frac {n}{b}}\right)+f(n)}
$$

其中 $a\geq 1$ ， $b>1$ ，$n$ 为问题规模， $a$ 为递归的子问题数量， $\frac{n}{b}$ 为每个子问题的规模（假设每个子问题的规模基本一样）， $f(n)$ 为递归以外进行的计算工作。

如果存在常数 ${\displaystyle \epsilon >0}$ ，有

$$
{\displaystyle f(n)=O\left(n^{\log _{b}(a)-\epsilon }\right)}
$$

则

$$
{\displaystyle T(n)=\Theta \left(n^{\log _{b}a}\right)}
$$

具体而言，对于 `(partial-tree elts n)` ：

- 问题规模为 $n$ 
- 递归的子问题数量 $a=2$ 
- 每个子问题的规模基本一样，视为 $\frac{n}{2}$ ，所以 $b=2$ 
- 递归以外进行的计算工作有
	- `(quotient (- n 1) 2)` 计算左子树的大小
	- `(car left-result)` 取出左子树
	- `(cdr left-result)` 取出剩余的元素表
	- `(- n (+ left-size 1))` 计算右子树的大小
	- `(car non-left-elts)` 取出剩余元素表的第一个元素，作为根节点
	- `(cdr non-left-elts)`
	- `(car right-result)` 取出右子树
	- `(cdr right-result)` 取出剩余的元素表
	- `(make-tree this-entry left-tree right-tree)`
	- 以上皆为常数时间的操作
	- 所以 $f(n)=Θ(1)$

所以

$$
T(n)=\Theta \left(n^{\log _{b}a}\right)=\Theta \left(n^{\log _{2}2}\right)=\Theta \left(n\right)
$$
