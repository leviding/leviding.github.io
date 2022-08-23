1. 在有些同学的尝试过程中，当赋值为 `undefined` 和 `null` 时，会自动推断成 `any` 。这是由于 `tsconfig.json` 中的配置有问题，把 `compilerOptions.strictNullChecks` 设置为 `true` 即可。目前发现团队中有部分项目都没有开启该配置，那么可能会在运行时出现意料之外的 `BUG`。

2. {  *// 允许 默认导入 没有设置默认导出（export default xxx）的模块*  *// 可以以 import xxx from 'xxx' 的形式来引入模块* "allowSyntheticDefaultImports":**true** }

3. 如何在页面上实现一个圆形的可点击区域。能想到用map+area或者svg的，我觉得html可能比较熟；能想到border-radius的，我觉得css可能比较熟。如果实在想不出来什么，我就引导他回答纯js实现，这个时候就问问怎么求一个点在圆上这种简单算法，加上js的Math几个api，怎么获取鼠标坐标什么的。

   用js实现千位分隔符（[千位分隔符_百度百科](https://link.zhihu.com/?target=http%3A//baike.baidu.com/view/3468964.htm%3Ffr%3Daladdin)），这道题挺考逻辑的，看起来简单，写起来不太容易，如果回答三位循环、字符串数组分隔之类的，可以深度问下去，在加上正负号什么的看看对方的应变能力。如果能用一条正则+replace搞定，那就加分啦。

   有一个高度自适应的div，里面有两个div，一个高度100px，希望另一个填满剩下的高度。这题有js解法、一般css解法、css3解法等。

   

   作者：张云龙
   链接：https://www.zhihu.com/question/26188893/answer/32360020
   来源：知乎
   著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

　　　　　　什么是闭包？

　　　　　　JS如何实现类，继承？

　　　　　　什么是冒泡和捕获？

　　　　　　JS有哪些数据类型？

　　　　　　Null和Undefined的区别？

　　　　　　判断时if是false的值？

　　　　　　isNaN（）的作用？

　　　　　　JS对象中的Array对象和String对象的各种方法

　　　　　　this关键字在不同环境下的指向

　　　　　　JS的作用域

　　　　　　setTimeout和setInterval

　　           了解CSS3或HTML5吗，都用过哪些



作者：陈小二
链接：https://www.zhihu.com/question/26188893/answer/33019317
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。