# Lisp 自学记录

目前在学 Scheme，持续更新 SICP 题解中。

## 学习资源

- Common Lisp
	- [Lisp Tutorial - YouTube](https://www.youtube.com/watch?v=ymSq4wHrqyU) 
- Scheme
	- [【CS公开课】计算机程序的构造和解释（SICP）【中英字幕】【FoOTOo&HITPT&Learning-SICP】_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Xx41117tr/)
	- [计算机程序的构造和解释(原书第2版)](https://book.douban.com/subject/1148282/)
	- [jiacai2050/sicp: 📖 SICP 读书笔记，习题解答 (github.com)](https://github.com/jiacai2050/sicp)
	- [huangz1990/SICP-answers: 我的 SICP 解题集 (github.com)](https://github.com/huangz1990/SICP-answers)
	- [sicp-solutions (schemewiki.org)](http://community.schemewiki.org/?sicp-solutions)

## 配置环境

### 操作系统

> We no longer support OS/2, DOS, or Windows, though it's possible that this software could be used on Windows Subsystem for Linux (we haven't tried).
> 
> 我们不再支持 OS/2、DOS 或 Windows，尽管该软件可能可以在 Linux 的 Windows 子系统上使用（我们还没有尝试过）。
> 
> https://www.gnu.org/software/mit-scheme/

所以本来只会使用 Windows 的我去安装了 Ubuntu 22.04 LTS……

### 编辑器

- [Visual Studio Code](https://code.visualstudio.com/)
- [Racket](https://racket-lang.org/)

### VS Code 扩展

- 通用
	- [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) by Jun Han
- Common Lisp
	- [Common Lisp](https://marketplace.visualstudio.com/items?itemName=qingpeng.common-lisp) by Qingpeng Li
- Scheme
	- [vscode-scheme](https://marketplace.visualstudio.com/items?itemName=sjhuangx.vscode-scheme) by Allen Huang

### Common Lisp 实现

- [Steel Bank Common Lisp (SBCL)](http://www.sbcl.org/)
	- 在 Code Runner 扩展的 `settings.json` 中
		- 确保对象 `"code-runner.executorMapByFileExtension"` 中含有 `".lisp": "sbcl --script"`
		- 确保对象 `"code-runner.executorMap"` 中也含有 `"lisp": "sbcl --script"`

## Scheme 实现

- [MIT/GNU Scheme](https://www.gnu.org/software/mit-scheme/)
	- 在 Code Runner 扩展的 `settings.json` 中
		- 确保对象 `"code-runner.executorMapByFileExtension"` 中含有 `".scm": "scheme <"`
		- 确保对象 `"code-runner.executorMap"` 中也含有 `"scheme": "scheme <"`
- DrRacket
	- version 8.6
	- bash 命令
		- `sudo apt-get update`
		- `sudo apt-get -y install racket`
