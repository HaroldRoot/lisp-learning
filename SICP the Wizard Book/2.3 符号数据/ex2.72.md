# 练习 2.72

## 题目

考虑你在练习 2.68 中设计的编码过程。

```scheme
;;;; SICP the Wizard Book/2.3 符号数据/ex2.68_encode.scm

(define (encode-symbol symbol tree)
    (cond ((leaf? tree)
           '())
          ((symbol-in-tree? symbol (left-branch tree))
           (cons 0 (encode-symbol symbol (left-branch tree))))
          ((symbol-in-tree? symbol (right-branch tree))
           (cons 1 (encode-symbol symbol (right-branch tree))))
          (else
           (error "bad symbol: ENCODE-SYMBOL" symbol))))

(define (symbol-in-tree? given-symbol tree)
    (not (false? (find (lambda (s)
                               (eq? s given-symbol))
                       (symbols tree))))) ; 取出 tree 中的所有 symbol

(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))
```

对于一个符号的编码，计算步数的增长速率是什么？

请注意，这时需要把在每个结点中检查符号表所需的步数包括在内。

一般性地回答这一问题是非常困难的。

现在考虑一类特殊情况，其中的 $n$ 个符号的相对频度如练习 2.71 所描述的。

请给出编码最频繁的符号所需的步数和最不频繁的符号所需的步数的增长速度（作为 $n$ 的函数）。

## 对于一个符号的编码，计算步数的增长速率是什么？

总的来说，对于一个符号的编码，计算步数的增长速率主要取决于树的深度，即 $O(n)$ 。

具体来说， `encode-symbol` 函数会在给定的树中搜索给定的符号。如果符号在树的左分支中，它会在左分支中递归地搜索该符号，并在结果前添加 `0` 。如果符号在树的右分支中，它会在右分支中递归地搜索该符号，并在结果前添加 `1` 。因此，每次递归调用都会向下移动到树的一个更深的层次。

由于这个过程是递归的，所以计算步数的增长速率将是 $O(n)$ ，其中 $n$ 是树的深度。这是因为在最坏的情况下，你可能需要遍历整个树才能找到给定的符号。

此外， `symbol-in-tree?` 数会检查给定的符号是否在树的符号表中。这个操作的复杂度也是 $O(n)$ ，其中 $n$ 是符号表的长度。然而，由于符号表的长度通常远小于树的深度，所以这个操作的影响通常可以忽略不计。

## 考虑练习 2.71 的特殊情况

在这种特殊情况下，我们有一棵 Huffman 树，其中各符号的相对频度分别是 $1,2,4,\cdots,2^{n-1}$ 。这意味着最频繁的符号的频度是 $2^{n-1}$ ，最不频繁的符号的频度是 $1$ 。

由于 Huffman 树的构造方式，最频繁的符号将位于树的最浅层次，而最不频繁的符号将位于树的最深层次。因此，编码最频繁的符号所需的步数将是常数（即，与 $n$ 无关），而编码最不频繁的符号所需的步数将与 $n$ 成正比。

具体来说：
- 编码最频繁的符号所需的步数的增长速度是 $O(1)$ ，因为无论 $n$ 的大小如何，都只需要一步就可以找到并编码最频繁的符号。
- 编码最不频繁的符号所需的步数的增长速度是 $O(n)$ ，因为需要遍历树的深度（即 $n-1$ ）才能找到并编码最不频繁的符号。