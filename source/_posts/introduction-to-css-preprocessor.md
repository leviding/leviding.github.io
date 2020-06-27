---
title: 初谈 CSS 预处理器
tags: [CSS, Sass, Scss, Less, JavaScript]
categories: [前端技术]
date: 2020-06-14 16:00:00
---

CSS 预处理器是什么？一般来说，它们基于 CSS 扩展了一套属于自己的 DSL（Domain Specific Language），来解决我们书写 CSS 时难以解决的问题：

- 语法不够强大，比如无法嵌套书写导致模块化开发中需要书写很多重复的选择器；
- 没有变量和合理的样式复用机制，使得逻辑上相关的属性值必须以字面量的形式重复输出，导致难以维护。

<!-- more -->

归结起来就是抽象能力。所以这就决定了 CSS 预处理器的主要目标：提供 CSS 缺失的样式层复用机制、减少冗余代码，提高样式代码的可维护性。这不是锦上添花，而恰恰是雪中送炭。

但是，CSS 预处理器也不是万金油，CSS 的好处在于简便、随时随地被使用和调试。预编译 CSS 步骤的加入，让我们开发工作流中多了一个环节，调试也变得更麻烦了。更大的问题在于，预编译很容易造成后代选择器的滥用。所以在使用 CSS 预处理器时，要注意避免出现此类问题。

Sass 中变量以 $ 打头比较不容易和 CSS 标准语法冲突。Less 中变量则以 @ 打头，虽说容易和后续规范更新的新语法冲突，但是理论上只要 CSS 规范不引入 `@a: b` 这样的规则，问题也不大。而且规范制定的时候也会参考很多现有的实现。

Sass 和 Less 的变量机制有很大的不同，Sass 是类似 JS 的块级作用域一样，可以在作用域内重新赋值而不影响外部，Less 是以全局的最后一次赋值为准。SASS 和 SCSS 只是两种语法风格而已，SCSS 更贴近 CSS 语法，前端写起来更舒服。Less 和 Sass 最常用的部分并没有明显的区别，不用太在意该用哪个，Just pick one。至于公司用哪个，跟着用就行，不出大问题不用考虑换。

## CSS 预处理器可以为我们提供以下“超能力”

下文复制自 [浅谈 CSS 预处理器（一）：为什么要使用预处理器？](https://github.com/cssmagic/blog/issues/73)，文中的示例代码均采用 Stylus 作为 CSS 预处理语言。

### 文件切分

页面越来越复杂，需要加载的 CSS 文件也越来越大，我们有必要把大文件切分开来，否则难以维护。传统的 CSS 文件切分方案基本上就是 CSS 原生的 `@import` 指令，或在 HTML 中加载多个 CSS 文件，这些方案通常不能满足性能要求。

CSS 预处理器扩展了 `@import` 指令的能力，通过编译环节将切分后的文件重新合并为一个大文件。这一方面解决了大文件不便维护的问题，另一方面也解决了一堆小文件在加载时的性能问题。

### 模块化

把文件切分的思路再向前推进一步，就是“模块化”。一个大的 CSS 文件在合理切分之后，所产生的这些小文件的相互关系应该是一个树形结构。

树形的根结节一般称作“入口文件”，树形的其它节点一般称作“模块文件”。入口文件通常会依赖多个模块文件，各个模块文件也可能会依赖其它更末端的模块，从而构成整个树形。

以下是一个简单的示例：

```
entry.less
 ├─ base.less
 │   ├─ normalize.less
 │   └─ reset.less
 ├─ layout.less
 │   ├─ header.less
 │   │   └─ nav.less
 │   └─ footer.less
 ├─ section-foo.less
 ├─ section-bar.less
 └─ ...
```

入口文件 `entry.less` 在编译时会引入所需的模块，生成 entry.css，然后被页面引用。

如果你用过其它拥有模块机制的编程语言，应该已经深有体会，模块化是一种非常好的代码组织方式，是开发者设计代码结构的重要手段。模块可以很清晰地实现代码的分层、复用和依赖管理，让 CSS 的开发过程也能享受到现代程序开发的便利。

### 选择器嵌套

选择符嵌套是文件内部的代码组织方式，它可以让一系列相关的规则呈现出层级关系。

### 变量

在变更出现之前，CSS 中的所有属性值都是“幻数”。你不知道这个值是怎么来的、它的什么样的意义。有了变量之后，我们就可以给这些“幻数”起个名字了，便于记忆、阅读和理解。

接下来我们会发现，当某个特定的值在多处用到时，变量就是一种简单而有效的抽象方式，可以把这种重复消灭掉，让你的代码更加 DRY。

变量让开发者更容易实现网站视觉风格的统一，也让“换肤”这样的需求变得更加轻松易行。

### 运算

光有变量还是不够的，我们还需要有运算。如果说变量让值有了意义，那么运算则可以让值和值建立关联。有些属性的值其实跟其它属性的值是紧密相关的，CSS 语法无法表达这层关系；而在预处理语言中，我们可以用变量和表达式来呈现这种关系。

举个例子，我们需要让一个容器最多只显示三行文字，在以前我们通常是这样写的：

```css
.wrapper {
	overflow-y: hidden;
	line-height: 1.5;
	max-height: 4.5em;  /* = 1.5 x 3 */
}
```

大家可以发现，我们只能用注释来表达 `max-height` 的值是怎么来的，而且注释中 `3` 这样的值也是幻数，还需要进一步解释。未来当行高或行数发生变化的时候，`max-height` 的值和注释中的算式也需要同步更新，维护起来很不方便。

接下来我们用预处理语言来改良一下：

```css
.wrapper
	$max-lines = 3
	$line-height = 1.5

	overflow-y: hidden
	line-height: $line-height
	max-height: unit($line-height * $max-lines, 'em')
```

乍一看，代码行数似乎变多了，但代码的意图却更加清楚了——不需要任何注释就把整件事情说清楚了。在后期维护时，只要修改那两个变量就可以了。

值得一提的是，这种写法还带来另一个好处。`$line-height` 这个变量可以是 `.wrapper` 自己定义的局部变量（比如上面那段代码），也可以从更上层的作用域获取：

```css
$line-height = 1.5  // 全局统一行高

body
	line-height: $line-height

.wrapper
	$max-lines = 3

	max-height: unit($line-height * $max-lines, 'em')
	overflow-y: hidden
```

这意味着 `.wrapper` 可以向祖先继承行高，而不需要为这个“只显示三行”的需求把自己的行高写死。有了运算，我们就有能力表达属性与属性之间的关联，它令我们的代码更加灵活、更加 DRY。

### 函数

把常用的运算操作抽象出来，我们就得到了函数。

开发者可以自定义函数，预处理器自己也内置了大量的函数。最常用的内置函数应该就是颜色的运算函数了吧！有了它们，我们甚至都不需要打开 Photoshop 来调色，就可以得到某个颜色的同色系变种了。

举个例子，我们要给一个按钮添加鼠标悬停效果，而最简单的悬停效果就是让按钮的颜色加深一些。我们写出的 CSS 代码可能是这样的：

```css
.button {
	background-color: #ff4466;
}
.button:hover {
	background-color: #f57900;
}
```

我相信即使是最资深的视觉设计师，也很难分清 `#ff4466` 和 `#f57900` 这两种颜色到底有什么关联。而如果我们的代码是用预处理语言来写的，那事情就直观多了：

```css
.button
	$color = #ff9833

	background-color: $color
	&:hover
		background-color: darken($color, 20%)
```

此外，预处理器的函数往往还支持默认参数、具名实参、`arguments` 对象等高级功能，内部还可以设置条件分支，可以满足复杂的逻辑需求。

### Mixin

Mixin 是 CSS 预处理器提供的又一项实用功能。Mixin 的形态和用法跟函数十分类似——先定义，然后在需要的地方调用，在调用时可以接受参数。它与函数的不同之处在于，函数用于产生一个值，而 Mixin 的作用是产生一段 CSS 代码。

Mixin 可以产生多条 CSS 规则，也可以只产生一些 CSS 声明。

一般来说，Mixin 可以把 CSS 文件中类似的代码块抽象出来，并给它一个直观的名字。比如 CSS 框架可以把一些常用的代码片断包装为 mixin 备用，在内部按需调用，或暴露给使用者在业务层调用。

举个例子，我们经常会用到 clearfix 来闭合浮动。在原生 CSS 中，如果要避免 clearfix 代码的重复，往往只能先定义好一个 `.clearfix` 类，然后在 HTML 中挂载到需要的元素身上：

```css
/* 为 clearfix 定义一个类 */
.clearfix {...}
.clearfix::after {...}
```

```html
<!-- 挂载到这两个元素身上 -->
<div class="info clearfix">...</div>
...
<footer class="clearfix">...</footer>
```

把表现层的实现暴露到了结构层，是不是很不爽？而在预处理器中，我们还可以选择另一种重用方式：

```css
// 为 clearfix 定义一个 mixin
clearfix()
    ...
    &::after
        ...

// 在需要的元素身上调用
.info
    clearfix()

footer
    clearfix()
```

### 工程化

CSS 预处理语言无法直接运行于浏览器环境，这意味着我们编写的源码需要编译为 CSS 代码之后才能用于网页。这似乎是一个门槛，需要我们付出“额外”的成本。

但在目前的大环境下，大多数项目的前端开发流程已经包含了构建环节，比如选择任何一个脚本模块化方案都是需要在部署时走一道打包程序的。所以对大多数团队来说，这个门槛其实已经跨过去一大半了。

而一旦接受了这种设定，我们还可以享受到“额外”的福利。在给 CSS 的开发加入编译环节的同时，还可以顺道加入其它构建环节，比如代码校验、代码压缩、代码后处理等等。

“代码后处理”是指 PostCSS 平台上各类插件所提供的功能，光是 Autoprefixer 这一项就已经值回票价了。我们再也不需要在 CSS 代码中手工添加浏览器前缀了，直接使用标准写法，剩下的事情让工具搞定吧！


## 参考资料

> 本文中大部分内容直接复制整合了参考资料中的内容，因为这些文章写的很好，没必要再用自己的话复述，因此取长补短，进行了整合，版权归原作者所有。

- [浅谈 CSS 预处理器（一）：为什么要使用预处理器？](https://github.com/cssmagic/blog/issues/73)
- [再谈 CSS 预处理器 - Baidu EFE](https://efe.baidu.com/blog/revisiting-css-preprocessors/)
- [CSS预处理器 - 郑海波](https://v.youku.com/v_show/id_XMTMwODk2MDkyNA==.html)