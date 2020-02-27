---
title: 译文：带你入门 CSS Grid 布局
tags: [CSS, Grid, 译文]
categories: [文章翻译]
date: 2017-05-16 15:50:30
---

三月中旬的时候，有一个对于 CSS 开发者来说很重要的消息，最新版的 Firefox 和 Chrome 已经正式支 CSS Grid 这一新特性啦。没错：我们现在就可以在最流行的两大浏览器上玩转 CSS Grid 啦 (≧▽≦)/~

<!-- more -->

## 为什么 CSS Grid 很重要？

因为 CSS Grid 布局是 Web 的第一个真正的布局系统。它的目的是将内容组织成行列的形式，最终使开发人员能高度控制我们眼前屏幕上页面的显示效果。这意味着我们终于可以摒弃多年的各种 hack 和 trick 了，CSS Grid 布局不仅仅可以使复杂的布局和精美的排版成为可能，而且还可以使其变的干净利落可维护。

通过使用 CSS Grid，Web开发变得更加简洁且对开发者更加友好了 :-D 。那么 Grid 是如何工作的咩？有些教程事无巨细，但是我认为我们应该从最基础的知识学起。下面我们将会实现一个比较简单的小例子，即在一个页面上放置一串字母。

在开始前，我们先添加几个标签：

```html
<div class="wrapper">
    <div class="letter">
        A
    </div>
    <div class="letter">
        B
    </div>
</div>
```

首先，我们使用 `font-size` 和 `color` 设置这些字母的字体和颜色，然后使用诸如 `align-items` 和 `justify-content` 之类的 `flexbox` 属性将其居中。CSS Grid 没有替换 `flexbox` 属性，尽可能保留了它们的功能。我们甚至可以将这些属性与 CSS Grid 结合。但是现在先让我们回到这个 demo：

![](https://cdn.css-tricks.com/wp-content/uploads/2017/03/Screenshot-2017-03-12-00.31.26.png)

在上面这个例子中，一个大的 `div` 又包含着两个 `div` ，它们默认属性是 `display: block`。接下来我们用 Grid layout 设置父类元素：

```css
.wrapper {
  display: grid;
}
```

在这我放一下完整的 HTML 和 CSS 代码：

```html
<div class="wrapper">
  <div class="letter">
    A
  </div>
  <div class="letter">
    B
  </div>
</div>
```

```css
body,html {
  padding: 0;
  margin: 0;
}

.wrapper {
  display: grid;
}

.letter {
  background-color: #0069b3;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
  font-size: 70px;
  color: white;
  line-height: 1;
  font-family: 'hobeaux-rococeaux-background', Helvetica;
  font-weight: 200;
  cursor: pointer;
  transition: all .3s ease;
}
```

则显示结果如下：

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/44537050-file_1494073145980_17031.png)

现在你可能看到似乎没什么变化。为什么这样呢？这不像设置 `display: inline-block;` 或者 `display: inline;` ，当我们把布局设为网格布局是不会发生很明显的变化。事实上，想让我们的 `grid` 起作用，首先需要给它设置一个确切的行数和列数。在这个例子中，我们可以让两个字母并排排列：

```css
.wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-column-gap: 1px;
  background-color: black;
}
```

让我们拆解一下上面的代码。首先我们用 `grid-template-columns` 创建了一个两列的网格，如果你以前没见过这样的，那 `1fr` 可能看起来比较奇怪 ，但它是有效的 CSS 单元，可以将每一列列为我们网格的一小部分。在这个例子中，意味着让两列等宽。

效果如下：

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/68383236-file_1494074163984_15c97.jpg)

看见效果了就开心了吧，哈哈。但是看到两列之间的黑线了吗？这是 `wrapper` 勾勒的每个字母 `div` 的背景，因为我们将 `grid-column-gap` 设置为了 `1px`。通常，我们会设置更大的距离，尤其是对于两个相邻的文本框来说。但在本例中，`1px` 就足够了。

如果我们再添加两个新字母会怎样呢？我们应该怎么改变布局？

```html
<div class='wrapper'>
  <div class='letter'>
    A
  </div>
  <div class='letter'>
    B
  </div>
  <div class='letter'>
    C
  </div>
  <div class='letter'>
    D
  </div>
</div>
```

看吧，加两个字母之后也没啥神奇的效果。加两个字母对网格没什么影响，为什么呢？因为我们已经将其设置成了两列，所以这两个字母的 `div` 直接被放在了它们下面，并且正好是 `1fr`宽：

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/38350889-file_1494074479637_773d.jpg)

但是现在我有一个疑问啊，为啥字母 A、C 之间以及 B、D 之间没有 `1px` 的距离╭(╯^╰)╮
因为 `grid-column-gap` 只用于列，我们刚才做的是在网格布局中增加了一行。那就必须使用 `grid-row-gap` 才能看到想要的效果：

```css
.wrapper {
  grid-column-gap: 1px;
  grid-row-gap: 1px;
  /* other styles go here */
  /* we could have also used the shorthand `grid-gap` */
}
```

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/74708114-file_1494075320081_3346.jpg)

现在我们已经创建好了一个一行一列的网格布局，所以接下来我们就得改变标记了。但是咱现在再挖掘下列的好玩的地方。如果给 `grid-template-columns` 属性添加另一个值会有啥变化？像这样：

```css
.wrapper {
 grid-template-columns: 1fr 1fr 1fr;
}
```

啊哈，这就添加了一个新的列啊。我们现在也可以清晰地看见 `wrapper` 的背景，因为现在那没东西显示：

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/87811828-file_1494075976891_7da4.jpg)

如果我们改变 `fr`，那一个非对称的网格布局就搞出来了。假如我们想让网格的第一列是其他两列的三倍：

这会使A和D两列的宽度大于其他两列：

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/77156156-file_1494076116435_d4d5.jpg)

好玩吧？我们没必要在担心负边距或者网格列的完美百分比。我们可以轻松地做很复杂的网格布局，而不用像以前那样用数学来算...
现在我们只需要给 `grid-template-columns` 属性添加一个新的值，一个网格列就奇迹般地出现了。

你可能会问，那=响应式网格怎么实现？那其实也很简单。比如我们默认想要显示为 2 列，如果屏幕为 500px 的时候我们想让其显示为 3 列，如果屏幕再大点，我们要4列。只需要这样写：

```css
.wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr;
  
  @media screen and (min-width: 500px) {
    grid-template-columns: 1fr 1fr 1fr;
  }
  
  @media screen and (min-width: 800px) {
    grid-template-columns: 1fr 1fr 1fr 1fr;
  }
}
```

确保在你能用电脑在新窗口打开下面这个 Demo 链接-[Demo](http://codepen.io/robinrendle/pen/Npjzyz?editors=1100)，来试试改变浏览器窗口大小，看看响应式效果。

![](https://res.cloudinary.com/css-tricks/image/fetch/f_auto,q_auto/https://cdn.css-tricks.com/wp-content/uploads/2017/03/media-query-grid.gif)

`grid-template-columns` 属性比本文展示的要更复杂，但是本文是很好的一个起点。接下来我们会学习 CSS Grid 中真正的革命性意义的属性： `grid-template-rows`

看下面的一小段代码，结合我们已经学的知识，搞明白这个新属性能干啥：

```css
.wrapper {
  display: grid;
  grid-template-columns: 3fr 1fr 1fr;
  grid-template-rows: 1fr 3fr;
}
```

我们现在可以设置行高之间的关系。如果我们把前面的行高设成 `1fr` ，最后一个则设置为 `3fr`，这意味着第二行的行高是第一行的3倍：

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/1029205-file_1494078413496_7ba6.png)

这可能看起来很简单，以前我们从没真正做到过这一点。我们总是不得不在一个特定元素上设置最小高度或者改变类名。我们以前从没以现在这样的方式创建过行之间的关系，这就是 CSS Grid 强大之处。

有了这些小知识和一些新属性，我们可以创建非常复杂的布局，不对称网格和响应式网格只是冰山一角。目前为止，只是对 CSS Grid 的初探，还有很多没有谈到的。但是我觉得 Jen Simmons 在写 Grid 的时候描述的最好：

> 我们要一直探索 CSS Grid，直到搞清楚它想做的是什么，它能勉强做什么和它做不了什么。设计师可能永远不会学 CSS 的代码，但是要足够了解 CSS 才能更好地理解我们的艺术媒介（artistic medium）。

当然，上面的代码起初看起来会有些奇怪。但是我想表达的意思是：我们不再需要使用臃肿的 CSS 框架，也不用管一大堆繁琐的布局。这就是 CSS Grid 真正让我兴奋的地方，它让我们以一种全新的方式看界面的显示。

我们不仅需要学习一大堆新属性，还要重新思考我们以前所学的东西。所以 CSS Grid 不仅仅是一个规范，它本身就是一个奇怪的哲学。

让我们一起来探索吧！


## 浏览器支持情况

绿色表示在列出的版本（及以上）的完全支持。黄色表示部分支持。红色表示不支持。有关完整的浏览器支持详情，请参阅 [Caniuse](http://caniuse.com/#feat=css-grid).

![](http://oiklhfczu.bkt.clouddn.com/17-5-6/97157600-file_1494078807714_cf0.png)


## 相关学习资源链接

- [Jen Simmons](http://jensimmons.com/)
- [Rachel Andrew](https://rachelandrew.co.uk/)
- [Grid Inspector Tools in Firefox is super handy](https://developer.mozilla.org/en-US/docs/Tools/Page_Inspector/How_to/Examine_grid_layouts)
- [ Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/)

---

> * 原文：[Getting Started with CSS Grid](https://css-tricks.com/getting-started-css-grid/)
> * 作者：[ROBIN RENDLE](https://css-tricks.com/author/robinrendle/)
> * 译者：[LeviDing](https://leviding.com)
