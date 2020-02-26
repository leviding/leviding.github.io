---
title: Iterable，Iterator，Generator 三者的区别与联系
tags: [JavaScript]
categories: [基础知识]
date: 2020-02-26 17:23:00
---

## Interable（可迭代对象）

Iterable 是指有 `[Symbol.iterator]` 属性的对象，这个属性 `obj[Symbol.iterator]` 就是 Iterator（迭代器）。也可以说可迭代对象是实现了 `Symbol.iterator` 方法的对象。

可迭代对象可以被 `for..of` 循环遍历，我们最常进行迭代操作的可迭代对象就是 Array，其实还有其他可迭代对象，例如 String、Set、Map、函数的 arguments 对象和 NodeList 对象等，这些对象都有默认的 `Symbol.iterator` 属性。

<!-- more -->

## Iterator（迭代器）

Iterator 必须有 `next()` 方法，它每次返回一个 `{done: Boolean, value: any}` 对象，这里 `done:true` 表明迭代结束，否则 `value` 就是下一个要迭代的值。


### 手写实现一个 Iterator

假设我们 `range` 对象，我们希望对其使用 `for..of` 循环：

```js
let range = {
  from: 1,
  to: 5
};

// 我们希望可以这样：
// for(let num of range) ... num=1,2,3,4,5 
```

为了让 `range` 对象可迭代，我们需要为对象添加一个名为 `Symbol.iterator` 的方法。当 `for..of` 循环启动时，它会调用这个方法（如果没找到，就会报错）。这个方法必须返回一个 迭代器（iterator） —— 一个有 next 方法的对象。从此开始，`for..of` 仅适用于这个被返回的对象。当 `for..of` 循环希望取得下一个数值，它就调用这个对象的 `next()` 方法。`next()` 方法返回的结果的格式必须是 `{done: Boolean, value: any}`，当 `done=true` 时，表示迭代结束，否则 `value` 是下一个值。

```js
let range = {
  from: 1,
  to: 5
};

// for..of 循环首先会调用这个
range[Symbol.iterator] = function() {

  // 它返回迭代器对象，接下来 for..of 仅与此迭代器一起工作
  return {
    current: this.from,
    last: this.to,

    // next() 在 for..of 的每一轮循环迭代中被调用
    next() {
      // 它将会返回 {done:.., value :...} 格式的对象
      if (this.current <= this.last) {
        return { done: false, value: this.current++ };
      } else {
        return { done: true };
      }
    }
  };
};

// 现在它可以运行了！
for (let num of range) {
  alert(num); // 1, 然后是 2, 3, 4, 5
}
```

请注意可迭代对象的核心功能：关注点分离。`range` 自身没有 `next()` 方法。相反，是通过调用 `range[Symbol.iterator]()` 创建了另一个对象，即所谓的“迭代器”对象，并且它的 `next` 会为迭代生成值。因此，迭代器对象和与其进行迭代的对象是分开的。

从技术上说，我们可以将它们合并，并使用 `range` 自身作为迭代器来简化代码。

就像这样：

```js
let range = {
  from: 1,
  to: 5,

  [Symbol.iterator]() {
    this.current = this.from;
    return this;
  },

  next() {
    if (this.current <= this.to) {
      return { done: false, value: this.current++ };
    } else {
      return { done: true };
    }
  }
};

for (let num of range) {
  alert(num); // 1, 然后是 2, 3, 4, 5
}
```

现在 `range[Symbol.iterator]()` 返回的是 `range` 对象自身：它包括了必需的 `next()` 方法，并通过 `this.current` 记忆了当前的迭代进程。这样更短，对吗？是的。有时这样也可以。

但缺点是，现在不可能同时在对象上运行两个 `for..of` 循环了：它们将共享迭代状态，因为只有一个迭代器，即对象本身。但是两个并行的 `for..of` 是很罕见的，即使在异步情况下。


### 无穷迭 Interator

此外，我们还可以将 `range` 设置为 `range.to = Infinity`，这时 `range` 则成为了无穷迭代器。或者我们可以创建一个可迭代对象，它生成一个无穷伪随机数序列。也是可能的。`next` 没有什么限制，它可以返回越来越多的值，这是正常的。当然，迭代这种对象的 `for..of` 循环将不会停止。但是我们可以通过使用 `break` 来停止它。


## Generator

Generator 是一个特殊函数，调用返回一个 Generator。

未完待续……



**参考：**

- [Iterables（可迭代对象）](https://zh.javascript.info/iterable)
- [JS 可迭代对象、迭代器、生成器](https://github.com/coconilu/Blog/issues/73)
- [ES6 迭代器与可迭代对象](https://segmentfault.com/a/1190000016824284)


