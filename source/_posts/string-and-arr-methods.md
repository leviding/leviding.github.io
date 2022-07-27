---
title: 字符串和数组常用方法总结
tags: [面试]
categories: [前端技术]
date: 2022-07-15 22:00:00
---

在 JavaScript 中，字符串和数组的方法特别多，日常也是最长用到的，所以梳理一下，加强记忆。

<!-- more -->

## 字符串方法

1. [str.indexOf(substr, pos)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/indexOf)：从给定位置 `pos` 开始，在 `str` 中查找 `substr`，如果没有找到，则返回 `-1`，否则返回匹配成功的位置。

2. [str.lastIndexOf(substr, position)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/lastIndexOf)：从字符串的末尾开始搜索到开头。

3. [str.includes(substr, pos)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/includes)：根据 `str` 中是否包含 `substr` 来返回 `true/false`。

4. [str.startsWith(substr)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/startsWith)：返回 `true/false`。

5. [str.endsWith(substr)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/endsWith)：返回 `true/false`。

6. [str.slice(start [, end])](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/slice)：返回字符串从 `start` 到（但不包括）`end` 的部分。

   > - 对原数据 **无修改**
   > - `start/end` 可以是负值，表示起始位置从字符串结尾计算

7. [str.substring(start [, end])](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substring)：返回字符串从 `start` 到（但不包括） `end` 的部分。这与 `slice` 几乎相同，但它允许 `start` 大于 `end`。

   > - 对原数据 **无修改**
   > - 不支持负参数，会被视为 `0`。

   ```js
   let str = "stringify";
   
   // 这些对于 substring 是相同的
   alert( str.substring(2, 6) ); // "ring"
   alert( str.substring(6, 2) ); // "ring"
   
   // ……但对 slice 是不同的：
   alert( str.slice(2, 6) ); // "ring"（一样）
   alert( str.slice(6, 2) ); // ""（空字符串）
   ```

8. [str.substr(start [, length])](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substr)：返回字符串从 `start` 开始的给定 `length` 的部分。

   > - 对原数据 **无修改**
   > - `start` 可以是负数，从结尾算起。
   > - 非核心规范内容，而是在附录 B 中

## 数组方法

1. `arr.at(i)`：返回数组 `arr` 索引 `index` 对应的元素。如果 `i >= 0`，则与 `arr[i]` 完全相同。`i` 为负数则从数组的末端向前数。

2. `arr.push(item1, item2, ...)`：在末端添加元素 `item`，return `arr.length`

   > - 对原数据 **有修改**

3. `arr.pop()`：从末端取出一个元素，return 取出的元素

   > - 对原数据 **有修改**

4. `arr.shift()`：从首端取出一个元素，return 取出的元素

   > - 对原数据 **有修改**

5. `arr.unshift(item1, item2, ...)`：在首端添加元素 `item`，return `arr.length`

   > - 对原数据 **有修改**

6. `arr.indexOf/lastIndexOf(item, from)`：从索引 `from` 开始搜索 `item`，如果找到则返回索引，否则返回 `-1`。

7. `arr.includes(item, from)`：从索引 `from` 开始搜索 `item`，如果找到则返回 `true`，否则返回 `false`。

   > - 可以正确识别 `NaN`，但 `indexOf/lastIndexOf` 不行

8. `arr.splice(start[, deleteCount, elem1, ..., elemN])`：从索引 `start` 开始修改 `arr`：删除 `deleteCount` 个元素并在当前位置插入 `elem1, ..., elemN`。最后返回被删除的元素所组成的数组。

   > - 对原数据 **有修改**
   > - 允许负数索引，从数组末尾开始计算位置

9. `arr.slice([start], [end])`：索引 `start` 到 `end`（不包括 `end`）的数组项复制到一个新的数组并返回。

   > - 对原数据 **无修改**
   > - 两个索引均可为负数，从末尾计算索引。

10. `arr.concat(arg1, arg2...)`：接受任意数量的参数（数组或值都可以），创建一个新数组，其中包含所有参数的值。

   > - 对原数据 **无修改**
   > - 通常只复制数组中的元素。其他对象，即使它们看起来像数组一样，但仍然会被作为一个整体添加：

   ```js
   let arr = [1, 2];
   let arrayLike = {
     0: "something",
     length: 1
   };

   alert( arr.concat(arrayLike) ); // 1,2,[object Object]
   ```

   > - 除非类数组对象具有 `Symbol.isConcatSpreadable` 属性，那么它就会被 `concat` 当作一个数组来处理：

   ```js
   let arr = [1, 2];

   let arrayLike = {
     0: "something",
     1: "else",
     [Symbol.isConcatSpreadable]: true,
     length: 2
   };

   alert( arr.concat(arrayLike) ); // 1,2,something,else
   ```

11. `arr.forEach((item, index, array) => { ...对 item 进行处理 })`：无返回值

12. `arr.find((item, index, array) => {})`：返回 `true` 则停止搜索并返回 `item`，否则返回 `undefined`。

13. `arr.findIndex/findLastIndex((item, index, array) => {})`：与 `arr.find` 基本相同，但返回找到的元素的 `index` 而不是 `item`，没找到则返回 `-1`。

14. `let results = arr.filter((item, index, array) => {});`：处理函数中 `return true` 则会将 `item push` 到 `results`，如果没有符合条件的，则 `results` 为空数组。

15. `map((item, index, array) => {})`：返回结果数组

16. `arr.sort(func)`：对数组进行原位排序

    > - 对原数据 **有修改**

17. `arr.reverse()`：颠倒 `arr` 中元素的顺序

    > - 对原数据 **有修改**

18. `arr.split(delim)`

19. `arr.join(glue)`

20. `arr.reduce((accumulator, item, index, array) => {}, [initial])`：

    > - `accumulator` 是上一个函数调用的结果，第一次等于 `initial`（如果提供了 `initial`）
    > - `arr.reduceRight` 和 `arr.reduce` 方法功能一样，只是遍历从右到左
