---
title: 字符串和数组常用方法总结
tags: [面试]
categories: [基础知识, 前端技术]
date: 2022-07-15 22:00:00
---

1. [str.indexOf(substr, pos)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/indexOf)：从给定位置 `pos` 开始，在 `str` 中查找 `substr`，如果没有找到，则返回 `-1`，否则返回匹配成功的位置。

2. [str.lastIndexOf(substr, position)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/lastIndexOf)：从字符串的末尾开始搜索到开头。

3. [str.includes(substr, pos)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/includes)：根据 `str` 中是否包含 `substr` 来返回 `true/false`。

4. [str.startsWith(substr)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/startsWith)：返回 `true/false`。

5. [str.endsWith(substr)](https://developer.mozilla.org/zh/docs/Web/JavaScript/Reference/Global_Objects/String/endsWith)：返回 `true/false`。

6. [str.slice(start [, end])](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/slice)：返回字符串从 `start` 到（但不包括）`end` 的部分。

   > - 对原数据 **无修改**
   > - `start/end` 可以是负值，表示起始位置从字符串结尾计算

7. [str.substring(start [, end])](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substring)：返回字符串从 `start` 到（但不包括） `end` 的部分。这与 `slice` 几乎相同，但它允许 `start` 大于 `end`。但不支持负参数，会被视为 `0`。

   > - 对原数据 **无修改**

   > ```js
   > let str = "stringify";
   > 
   > // 这些对于 substring 是相同的
   > alert( str.substring(2, 6) ); // "ring"
   > alert( str.substring(6, 2) ); // "ring"
   > 
   > // ……但对 slice 是不同的：
   > alert( str.slice(2, 6) ); // "ring"（一样）
   > alert( str.slice(6, 2) ); // ""（空字符串）
   > ```

8. [str.substr(start [, length])](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/substr)：返回字符串从 `start` 开始的给定 `length` 的部分。`start` 可以是负数，从结尾算起。

   > - 对原数据 **无修改**
   > - 非核心规范内容，而是在附录 B 中。

9. 