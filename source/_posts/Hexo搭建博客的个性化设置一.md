---
title: Hexo 搭建博客的个性化设置一
tags: [Hexo, Next, Site]
categories: [项目实战]
date: 2017-03-01 17:17:54
---

## 文字居中（写博客时）

在你博客文章中需要居中处加上下面这段代码即可，中间的文字改成你所需要的文字。

`<blockquote class="blockquote-center">优秀的人，不是不合群，而是他们合群的人里没有你</blockquote>`

<!-- more -->

## 为博客加上GitHub丝带

如果是 Next 主题（其他主题也差不多），添加 GitHub 丝带：在 `themes\next\layout\_layout.swig` 中加入相关代码，记得修改自己的链接。

- 相关代码你可以在 GitHub 官方网站 [GitHub Ribbons](https://github.com/blog/273-github-ribbons) 上进行选择。

## 加入作者版权信息

我们可以为博客文章加入作者版权信息。例如 `本文地址：http://www.dingxuewen.com/article/前端学习笔记15/  转载请注明出处，谢谢！`等等。

对 Next 主题而言，先找到 `/themes/next/layout/_macro/post.swig`，再找到其中的微信订阅部分，如下所示：

```js
<div>
  {% if not is_index %}
    {% include 'wechat-subscriber.swig' %}
  {% endif %}
</div>
```

然后直接在其上面添加如下代码段：

```js
<div align="center">
  {% if not is_index %}
    <div class="copyright">
    <p><span>
    <b>本文地址：</b><a href="{{ url_for(page.path) }}" title="{{ page.title }}">{{ page.permalink }}</a><br /><b>转载请注明出处，谢谢！</b>
    </span></p>
    </div>
  {% endif %}
</div>
```

当然，在上面这段代码，你可以进行一些个性化编写，可以展示你自己个性化的版权信息。

## 为博客加入动态背景

首先找到 `\themes\next\layout\_layout.swig`，在末尾前加上下面一句:（这里提供两种样式，当然你也可以自由更改）。

- 默认灰色线条

```js
<script type="text/javascript" src="/js/src/particle.js"></script>
```

- 浅蓝色线条

```js
<script type="text/javascript" src="/js/src/particle.js" count="50" zindex="-2" opacity="1" color="0,104,183"></script>
```

然后在 `themes\source\js\src\` 下新建文件 `particle.js` 写上以下代码:

```js
!function(){function n(n,e,t){return n.getAttribute(e)||t}function e(n){return document.getElementsByTagName(n)}function t(){var t=e("script"),o=t.length,i=t[o-1];return{l:o,z:n(i,"zIndex",-1),o:n(i,"opacity",.5),c:n(i,"color","0,0,0"),n:n(i,"count",99)}}function o(){c=u.width=window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth,a=u.height=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight}function i(){l.clearRect(0,0,c,a);var n,e,t,o,u,d,x=[w].concat(y);y.forEach(function(i){for(i.x+=i.xa,i.y+=i.ya,i.xa*=i.x>c||i.x<0?-1:1,i.ya*=i.y>a||i.y<0?-1:1,l.fillRect(i.x-.5,i.y-.5,1,1),e=0;e<x.length;e++)n=x[e],i!==n&&null!==n.x&&null!==n.y&&(o=i.x-n.x,u=i.y-n.y,d=o*o+u*u,d<n.max&&(n===w&&d>=n.max/2&&(i.x-=.03*o,i.y-=.03*u),t=(n.max-d)/n.max,l.beginPath(),l.lineWidth=t/2,l.strokeStyle="rgba("+m.c+","+(t+.2)+")",l.moveTo(i.x,i.y),l.lineTo(n.x,n.y),l.stroke()));x.splice(x.indexOf(i),1)}),r(i)}var c,a,u=document.createElement("canvas"),m=t(),d="c_n"+m.l,l=u.getContext("2d"),r=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame||function(n){window.setTimeout(n,1e3/45)},x=Math.random,w={x:null,y:null,max:2e4};u.id=d,u.style.cssText="position:fixed;top:0;left:0;z-index:"+m.z+";opacity:"+m.o,e("body")[0].appendChild(u),o(),window.onresize=o,window.onmousemove=function(n){n=n||window.event,w.x=n.clientX,w.y=n.clientY},window.onmouseout=function(){w.x=null,w.y=null};for(var y=[],s=0;m.n>s;s++){var f=x()*c,h=x()*a,g=2*x()-1,p=2*x()-1;y.push({x:f,y:h,xa:g,ya:p,max:6e3})}setTimeout(function(){i()},100)}();
```

## 为博客加入鼠标点击显示红心

鼠标点击小红心在 `\themes\next\source\js\src` 文件目录下添加 `love.js` 文件。内容为：

```javascript
!function(e,t,a){function n(){c(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"),o(),r()}function r(){for(var e=0;e<d.length;e++)d[e].alpha<=0?(t.body.removeChild(d[e].el),d.splice(e,1)):(d[e].y--,d[e].scale+=.004,d[e].alpha-=.013,d[e].el.style.cssText="left:"+d[e].x+"px;top:"+d[e].y+"px;opacity:"+d[e].alpha+";transform:scale("+d[e].scale+","+d[e].scale+") rotate(45deg);background:"+d[e].color+";z-index:99999");requestAnimationFrame(r)}function o(){var t="function"==typeof e.onclick&&e.onclick;e.onclick=function(e){t&&t(),i(e)}}function i(e){var a=t.createElement("div");a.className="heart",d.push({el:a,x:e.clientX-5,y:e.clientY-5,scale:1,alpha:1,color:s()}),t.body.appendChild(a)}function c(e){var a=t.createElement("style");a.type="text/css";try{a.appendChild(t.createTextNode(e))}catch(t){a.styleSheet.cssText=e}t.getElementsByTagName("head")[0].appendChild(a)}function s(){return"rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"}var d=[];e.requestAnimationFrame=function(){return e.requestAnimationFrame||e.webkitRequestAnimationFrame||e.mozRequestAnimationFrame||e.oRequestAnimationFrame||e.msRequestAnimationFrame||function(e){setTimeout(e,1e3/60)}}(),n()}(window,document);
```

找到 `\themes\next\layout\_layout.swing` 文件，在文件的后面，`</body>` 之前 添加以下代码：

```javascript
<!-- 小红心 -->
<script type="text/javascript" src="/js/src/love.js"></script>
```

## 给博客添加 LICENSE

在主题配置文件中添加下面这段代码（添加之前好好看看你的主题配置文件是否已经包含这段代码，已经包含就不用再加一遍了，因为重复会报错），这个 LICENSE 显示在侧边栏。

```
# Creative Commons 4.0 International License.
# http://creativecommons.org/
# Available: by | by-nc | by-nc-nd | by-nc-sa | by-nd | by-sa | zero
creative_commons: by-nc-sa
#creative_commons:
```

## 添加 Local Search 功能

### 安装 hexo 插件

在你的站点文件夹中，用 shell 等运行下面这行代码：

```
$ npm install hexo-generator-searchdb --save
```

### 编辑站点配置文件

添加以下字段：

```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

### 启用本地搜索

编辑主题配置文件启用本地搜索

```
# Local search
local_search:
  enable: true
```

## 修改字体大小

打开 `\themes\next\source\css\ _variables\base.styl` 文件，将 `$font-size-base` 改成 `16px`，如下所示：

```css
$font-size-base           = 16px
```

## 修改网页配色等

### 取色

取色可以用 QQ，打开 QQ 按 Ctrl+Alt+A 开始截图，将鼠标移到文字上，按住 Ctrl 键即可看到该颜色的 16 进制代码。也可以用 chrome 浏览器的 develop tool 取色，选取喜欢的颜色。

修改 `\themes\next\source\css\ _variables\base.styl` 文件，找到文件开头的 `colors for use across theme`，加入自定义颜色，在 `$orange = #fc6423` 下加入下面这段代码：

```css
// 下面是我自定义的颜色
$my-link-blue = #0593d3  //链接颜色
$my-link-hover-blue = #0477ab  //鼠标悬停后颜色
```

### 修改超链接颜色

打开 `\themes\next\source\css\ _variables\base.styl` 文件，像下面这样改掉这几行：

```css
// Global link color.
$link-color                   = $my-link-blue
$link-hover-color             = $my-link-hover-blue
$link-decoration-color        = $gray-lighter
$link-decoration-hover-color  = $my-link-hover-blue
```

### 修改小型代码块颜色

我修改 `<code>` 样式是因为我开启了 `highlight`，`highlight` 在渲染 `<pre><code>` 标签的同时也渲染了 `<code>` 标签，而且优先级高，所以才会出现方法一中这种不开启 `!important`，样式就不起作用的问题。在方法一使用了 `!important` 使得此处对 `<code>` 的样式优先级最高，所以设置成功。

#### 方法一

打开 `\themes\next\source\css\ _variables\base.styl` 文件，修改如下：

在下面这段代码：

```css
// Code & Code Blocks
// --------------------------------------------------
$code-font-family               = $font-family-monospace
$code-font-size                 = 14px
$code-font-size                 = unit(hexo-config('font.codes.size'), px) if hexo-config('font.codes.size') is a 'unit'
$code-border-radius             = 4px
```

下方加入下面这段代码:

```css
code {
	color:#dd0055 !important;
	background:#eee !important;
}
```

#### 方法二

你也可以不用方法一（建议使用方法一，因为第二种可能会失效，被其他的样式定义覆盖），而是在 `source/css/_variables/custom.styl` 文件中设定 `$code-foreground` 和 `$code-background` 的值，也是用的优先级。

```css
$code-foreground = #fc6423
$code-background = #fc6423
#此处颜色只是例子，你自己设置。
```

### 修改其他颜色

修改：`themes\next\source\css\_variables\.base.styl` 文件：

```css
$grey-dim     = #666         >>>      $grey-dim     = #353535
$black-light  = #555         >>>      $black-light  = #353535
$blue-bright  = #87daff      >>>      $blue-bright  = #45c5ff
```

## 加入统计和提高索引量

### 添加 sitemap 插件

谷歌与百度的站点地图，前者适用于其他搜索引擎，用来手动提交以增加收录。

#### sitemap 安装

在你的站点文件夹中，用 shell 等分次运行下面这两行代码：

```
npm install hexo-generator-sitemap@1 --save
npm install hexo-generator-baidu-sitemap@0.1.1 --save
```

#### 设置站点配置文件

在站点配置文件中添加代码：

```
# hexo sitemap网站地图
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```

 1. 配置成功后，hexo 编译时会在 hexo 站点根目录生成 sitemap.xml 和 baidusitemap.xml。其中 sitemap.xml 适合提交给谷歌搜素引擎，baidusitemap.xml 适合提交百度搜索引擎。
 2. 其次，在站点根目录下新建一个 robots.txt 文件，其中添加下面的一段代码（具体网站改为你自己的网址）：

```
# hexo robots.txt
User-agent: *
Allow: /
Allow: /archives/

Disallow: /vendors/
Disallow: /js/
Disallow: /css/
Disallow: /fonts/
Disallow: /vendors/
Disallow: /fancybox/

Sitemap: http://www.dingxuewen.com/sitemap.xml
Sitemap: https://www.dingxuewen.com/sitemap.xml
```

#### 给非友情链添加标签

经过 chinaz 站长工具友情链接检测，发现有不必要的 PR 值输出，对于非友情链接的PR值输出，我们可以加上 nofollow 便签避免不必要的 PR 输出。方法是给链接加上 `rel="external nofollow"` 属性。例如：


找到 `\themes\next\layout\_partials\footer.swig` 文件，将下面代码：

```html
{{ __('footer.powered', '<a class="theme-link" href="http://hexo.io">Hexo</a>') }}
```

改成：

```html
{{ __('footer.powered', '<a class="theme-link" href="http://hexo.io" rel="external nofollow">Hexo</a>') }}
```

将下面代码：

```html
<a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
```

改成：

```html
<a class="theme-link" href="https://github.com/iissnan/hexo-theme-next" rel="external nofollow">
```

### 加入 Baidu 站长统计

先准备一些代码。站长统计，注册并获取统计代码：

```js
&nbsp;&nbsp;|&nbsp;&nbsp;
<script type="text/javascript">
  var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
  document.write(xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' type='text/javascript'%3E%3C/script%3E"));
</script>
```

修改底栏:找到 `\themes\next\layout\_partials\footer.swig` 文件,加入上面这段代码，出于保护隐私的考虑，我编辑掉了部分关键代码，直接复制上面的无法使用。注意把上面的 `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` 换成你自己的站长统计代码。

### 在页脚加入地图

在页脚加入百度地图和谷歌地图链接：

找到 `\themes\next\layout\_partials\footer.swig` 文件，百度和 Google 网站地图，上面已经安装了，这是插入到底栏的代码：

```html
&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="/sitemap.xml">Google网站地图</a></span>
&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="/baidusitemap.xml">百度网站地图<
```

### 添加 Baidu 自动推送

百度自动推送代码，在页面被访问时，页面URL将立即被推送给百度，可以增加百度收录：找到 `\themes\next\layout\_partials\footer.swig` 或 `\themes\next\layout\_macro\post.swig` 文件，（Next 主题已经有了 `\themes\next\layout\_scripts\baidu-push.swig`）添加下面的代码。

```js
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https'){
   bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';
  }
  else{
  bp.src = 'http://push.zhanzhang.baidu.com/push.js';
  }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
```

### [不蒜子](http://ibruce.info/2015/04/04/busuanzi/)统计

找到 `\themes\next\layout\_partials\footer.swig` 文件，加入下面不蒜子统计代码：

```html
&nbsp;&nbsp;|&nbsp;&nbsp;本页点击 <span id="busuanzi_value_page_pv"></span> 次
&nbsp;&nbsp;|&nbsp;&nbsp;本站总点击 <span id="busuanzi_value_site_pv"></span> 次
&nbsp;&nbsp;|&nbsp;&nbsp;您是第 <span id="busuanzi_value_site_uv"></span> 位访客

<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js">
</script>
```

### 对上面的几个设置举例

```html
<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="icon-next-heart fa fa-heart"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}

  &nbsp;&nbsp;|&nbsp;&nbsp;
  <script type="text/javascript">
    var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' type='text/javascript'%3E%3C/script%3E"));
  </script>

  &nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="/sitemap.xml">Google网站地图</a></span>
  &nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="/baidusitemap.xml">百度网站地图</a></span>

  </span>
</div>

<div class="powered-by">
  {{ __('footer.powered', '<a class="theme-link" href="http://hexo.io">Hexo</a>') }}
</div>

<div class="theme-info">
  {{ __('footer.theme') }} -
  <a class="theme-link" href="https://github.com/iissnan/hexo-theme-next">
    NexT{% if theme.scheme %}.{{ theme.scheme }}{% endif %}
  </a>
</div>

&nbsp;&nbsp;|&nbsp;&nbsp;本站总点击 <span id="busuanzi_value_site_pv"></span> 次
&nbsp;&nbsp;|&nbsp;&nbsp;您是第 <span id="busuanzi_value_site_uv"></span> 位访客

<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js">
</script>

<script>
(function(){
    var bp = document.createElement('script');
    bp.src = '//push.zhanzhang.baidu.com/push.js';
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>

{% block footer %}{% endblock %}
```
