# 斐波那契数列

## 题目

第 28 页，练习 1.13：证明 $\text{Fib}(n)$ 是最接近 $\frac{\phi^n}{\sqrt{ 5 }}$ 的整数，其中 $\phi=\frac{1+\sqrt{ 5 }}{2}$ 。提示：利用归纳法和斐波那契数的定义，证明 $\text{Fib}(n)=\frac{\phi^n-\gamma^n}{\sqrt{ 5 }}$ 。

## 证明

首先需要证明 $\text{Fib}(n)=\frac{\phi^n-\gamma^n}{\sqrt{ 5 }}$ ，其中 $\gamma=\frac{1-\sqrt{ 5 }}{2}$ 。使用数学归纳法来证明这个等式。当 $n=0$ 时，等式成立，因为 $\text{Fib}(0)=0=\frac{\phi^0-\gamma^0}{\sqrt{ 5 }}$ 。假设当 $n=k$ 时，等式也成立，即 $\text{Fib}(k)=\frac{\phi^k-\gamma^k}{\sqrt{ 5 }}$ 。那么当 $n=k+1$ 时，由斐波那契数的定义，有
$$
\text{Fib}(k+1)=\text{Fib}(k)+\text{Fib}(k-1)
$$
将假设代入上式，得
$$
\text{Fib}(k+1)=\frac{\phi^k-\gamma^k}{\sqrt{ 5 }}+\frac{\phi^{k-1}-\gamma^{k-1}}{\sqrt{ 5 }}
$$
化简后，得
$$
\text{Fib}(k+1)=\frac{\phi^{k-1}(\phi+1)-\gamma^{k-1}(\gamma+1)}{\sqrt{ 5 }}
$$
由于 $\phi$ 和 $\gamma$ 都是方程 $x^2-x-1=0$ 的根，所以 $\phi+1=\phi^2$ ， $\gamma+1=\gamma^2$ 。代入上式，得
$$
\text{Fib}(k+1)=\frac{\phi^{k+1}-\gamma^{k+1}}{\sqrt{ 5 }}
$$
这就证明了当 $n=k+1$ 时，等式也成立。因此，由数学归纳法，可以得出 $\text{Fib}(n)=\frac{\phi^n-\gamma^n}{\sqrt{ 5 }}$ 对任意自然数 $n$ 都成立。

然后需要证明 $\text{Fib}(n)$ 是最接近 $\frac{\phi^n}{\sqrt{ 5 }}$ 的整数。可以利用上面证明的等式，将 $\text{Fib}(n)$ 与 $\frac{\phi^n}{\sqrt{ 5 }}$ 的差值表示为
$$
\text{Fib}(n)-\frac{\phi^n}{\sqrt{ 5 }}=-\frac{\gamma^n}{\sqrt{ 5 }}
$$
由于 $|\gamma|<1$ ，所以当 $n$ 越大时， $\gamma^n$ 越接近于 $0$ 。因此， $\text{Fib}(n)$ 与 $\frac{\phi^n}{\sqrt{ 5 }}$ 的差值的绝对值越小，即 $\text{Fib}(n)$ 越接近于 $\frac{\phi^n}{\sqrt{ 5 }}$ 。另一方面，由于 $\text{Fib}(n)$ 是整数，而 $\frac{\phi^n}{\sqrt{ 5 }}$ 是无理数，所以 $\text{Fib}(n)$ 与 $\frac{\phi^n}{\sqrt{ 5 }}$ 的差值不可能为 $0$ 。因此， $\text{Fib}(n)$ 是最接近 $\frac{\phi^n}{\sqrt{ 5 }}$ 的整数。

## 思考 qwq

我自己额外的疑惑：在刚刚的证明过程中，$\sqrt{ 5 }$ 一直没有参与运算，为什么 $\text{Fib}(n)=\frac{\phi^n-\gamma^n}{\sqrt{ 5 }}$ 而不是 $\text{Fib}(n)=\phi^n-\gamma^n$ ？$\sqrt{ 5 }$ 在这里有什么作用？数学家是怎么确定分母应该是 $\sqrt{ 5 }$ 的？

省流：$\sqrt{ 5 }$ 的出现是为了使通项公式满足初始条件 $F(1)=1$ 。

具体来说，如果假设斐波那契数列的通项公式是 $F(n)=A\phi^n+B\gamma^n$ ，其中 $A$ 和 $B$ 是常数，那么可以利用递推关系式和初始条件来求解 $A$ 和 $B$ 。由递推关系式，有
$$
F(n)=A\phi^n+B\gamma^n=A\phi^{n-1}+B\gamma^{n-1}+A\phi^{n-2}+B\gamma^{n-2}
$$
化简后，得
$$
A(\phi^n-\phi^{n-1}-\phi^{n-2})+B(\gamma^n-\gamma^{n-1}-\gamma^{n-2})=0
$$
由于 $\phi$ 和 $\gamma$ 都是方程 $x^2-x-1=0$ 的根，所以 $\phi^n-\phi^{n-1}-\phi^{n-2}=0$ ， $\gamma^n-\gamma^{n-1}-\gamma^{n-2}=0$ 。因此，上式对任意 $n$ 都成立，无论 $A$ 和 $B$ 取什么值。这说明，不能仅仅利用递推关系式来确定 $A$ 和 $B$ ，还需要利用初始条件。由初始条件，有
$$
F(0)=A\phi^0+B\gamma^0=0
$$
$$
F(1)=A\phi^1+B\gamma^1=1
$$
解得
$$
A=\frac{1}{\sqrt{ 5 }}
$$
$$
B=-\frac{1}{\sqrt{ 5 }}
$$
因此，斐波那契数列的通项公式为
$$
F(n)=\frac{1}{\sqrt{ 5 }}\phi^n-\frac{1}{\sqrt{ 5 }}\gamma^n=\frac{\phi^n-\gamma^n}{\sqrt{ 5 }}
$$
可以看出， $\sqrt{ 5 }$ 的出现是为了使 $A$ 和 $B$ 满足初始条件，而不是随意添加的。如果省略了 $\sqrt{ 5 }$ ，那么通项公式就不会满足初始条件，也就不是正确的通项公式了。