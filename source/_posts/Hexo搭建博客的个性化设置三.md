---
title: Hexo 搭建博客的个性化设置三
tags: [Hexo, Next, Site]
categories: [项目实战]
date: 2017-03-11 12:25:30
---

## 前言

本没有想再写一篇 [Hexo 搭建博客]系列的文章，但是看到还是有很多人想优化自己的博客，但是无从下手，我也是这么走过来的，在此也向我看过的相关博文的作者表示感谢，谢谢你们的文章让我进步。当然，在写文章的时候难免有些小错误，希望看到的人批评指正。在博客搭建的时候有什么问题也可以在我的博客里留言，我每天都会看，有时间会及时回复的。

<!-- more -->

再说下我为什么选择 NexT 主题：首先是这个主题的样式简洁大方，却又不失强大的功能。再者就是主题作者对此开源项目的维护较好，所以我选择了 NexT 主题。

既然是系列文章，我在这就贴出在此之前写的两篇文章的链接吧：

- [Hexo 搭建博客的个性化设置一](http://www.dingxuewen.com/article/Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2%E7%9A%84%E4%B8%AA%E6%80%A7%E5%8C%96%E8%AE%BE%E7%BD%AE%E4%B8%80/)
- [Hexo 搭建博客的个性化设置二](http://www.dingxuewen.com/article/Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2%E7%9A%84%E4%B8%AA%E6%80%A7%E5%8C%96%E8%AE%BE%E7%BD%AE%E4%BA%8C/)

## 优化主题 sidebar 头像

就是为主题 `sidebar` 头像添加圆形化旋转的效果。修改 `/themes/next/source/css/_common/components/sidebar/sidebar-author.styl` 文件，我的整个 `sidebar-author.styl` 文件的代码如下，你可以直接复制这段代码去替换你这个文件中的所有代码。

有一个注意事项，就是你要保证你的头像，也就是 `avatar.jpg` 这个图片是正方形，不是的话你要将其修改成正方形，这样才能通过样式将其展现为很好看的正圆，否则会是一个椭圆形。

```css
.site-author-image {
  display: block;
  margin: 0 auto;
  padding: $site-author-image-padding;
  max-width: $site-author-image-width;
  height: $site-author-image-height;
  border: $site-author-image-border-width solid $site-author-image-border-color;
  
  /* 头像圆形 */
  border-radius: 80px;
  -webkit-border-radius: 80px;
  -moz-border-radius: 80px;
  box-shadow: inset 0 -1px 0 #333sf;
  
  /* 设置循环动画 [animation: (play)动画名称 (2s)动画播放时长单位秒或微秒 (ase-out)动画播放的速度曲线为以低速结束 (1s)等待1秒然后开始动画 (1)动画播放次数(infinite为循环播放) ]*/
  -webkit-animation: play 2s ease-out 1s 1;
  -moz-animation: play 2s ease-out 1s 1;
  animation: play 2s ease-out 1s 1;
  
  /* 鼠标经过头像旋转360度 */
  -webkit-transition: -webkit-transform 1.5s ease-out;
  -moz-transition: -moz-transform 1.5s ease-out;
  transition: transform 1.5s ease-out;
}

img:hover {
  /* 鼠标经过停止头像旋转 
  -webkit-animation-play-state:paused;
  animation-play-state:paused;*/
  
  /* 鼠标经过头像旋转360度 */
  -webkit-transform: rotateZ(360deg);
  -moz-transform: rotateZ(360deg);
  transform: rotateZ(360deg);
}

/* Z 轴旋转动画 */
@-webkit-keyframes play {
  0% {
    -webkit-transform: rotateZ(0deg);
  }
  100% {
    -webkit-transform: rotateZ(-360deg);
  }
}

@-moz-keyframes play {
  0% {
    -moz-transform: rotateZ(0deg);
  }
  100% {
    -moz-transform: rotateZ(-360deg);
  }
}

@keyframes play {
  0% {
    transform: rotateZ(0deg);
  }
  100% {
    transform: rotateZ(-360deg);
  }
}

.site-author-name {
  margin: $site-author-name-margin;
  text-align: $site-author-name-align;
  color: $site-author-name-color;
  font-weight: $site-author-name-weight;
}

.site-description {
  margin-top: $site-description-margin-top;
  text-align: $site-description-align;
  font-size: $site-description-font-size;
  color: $site-description-color;
}
```

## 小红心优化

在 [Hexo 搭建博客的个性化设置一](http://www.dingxuewen.com/article/Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2%E7%9A%84%E4%B8%AA%E6%80%A7%E5%8C%96%E8%AE%BE%E7%BD%AE%E4%B8%80/#为博客加入鼠标点击显示红心) 这篇文章中我写了如何为博客加入鼠标点击显示小红心，但是如果我们只想在博客的某个页面添加这个功能呢？

那么就可以在 `\themes\next\source\js\src` 文件目录下添加 `love.js` 文件。内容为：

```js
!function(e,t,a){function n(){c(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"),o(),r()}function r(){for(var e=0;e<d.length;e++)d[e].alpha<=0?(t.body.removeChild(d[e].el),d.splice(e,1)):(d[e].y--,d[e].scale+=.004,d[e].alpha-=.013,d[e].el.style.cssText="left:"+d[e].x+"px;top:"+d[e].y+"px;opacity:"+d[e].alpha+";transform:scale("+d[e].scale+","+d[e].scale+") rotate(45deg);background:"+d[e].color+";z-index:99999");requestAnimationFrame(r)}function o(){var t="function"==typeof e.onclick&&e.onclick;e.onclick=function(e){t&&t(),i(e)}}function i(e){var a=t.createElement("div");a.className="heart",d.push({el:a,x:e.clientX-5,y:e.clientY-5,scale:1,alpha:1,color:s()}),t.body.appendChild(a)}function c(e){var a=t.createElement("style");a.type="text/css";try{a.appendChild(t.createTextNode(e))}catch(t){a.styleSheet.cssText=e}t.getElementsByTagName("head")[0].appendChild(a)}function s(){return"rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"}var d=[];e.requestAnimationFrame=function(){return e.requestAnimationFrame||e.webkitRequestAnimationFrame||e.mozRequestAnimationFrame||e.oRequestAnimationFrame||e.msRequestAnimationFrame||function(e){setTimeout(e,1e3/60)}}(),n()}(window,document);
```

之后呢，不在 `\themes\next\layout\_layout.swing` 文件中添加代码，而是在你想要显示红心的页面的 Markdown 文件中加入下面这段代码,例如我就在我的留言板页面的 Markdown 文件中加入了下面这段代码。

```js
<!-- 小红心 -->
<script type="text/javascript" src="/js/src/love.js"></script>
```

## 文章内文本样式

Markdown 毕竟是为了方便写作，在样式上过于单调。我们可以自己来给文章加一些样式。NexT 作者提供了一个供用户自己定义样式的文件：`\themes\next\source\css\_custom\custom.stly`。可以按照自己的需要写。

## 设置动态title

在 `\themes\next\source\js\src` 目录下新建 `dytitle.js`。添加以下内容：

```js
<!--卖萌-->
var OriginTitile = document.title;
var titleTime;
document.addEventListener('visibilitychange', function () {
    if (document.hidden) {
        $('[rel="icon"]').attr('href', "/img/TEP.ico");
        document.title = ' 你不理我了！';
        clearTimeout(titleTime);
    }
    else {
        $('[rel="icon"]').attr('href', "/favicon.ico");
        document.title = ' 么么哒 ' + OriginTitile;
        titleTime = setTimeout(function () {
            document.title = OriginTitile;
        }, 2000);
    }
});
```

更改 `\themes\next\layout\_layout.swig`。在 `</body` 之前添加：

```js
<!--卖萌-->
<script type="text/javascript" src="/js/src/dytitle.js"></script>
```

## 添加听音乐

### 代码设置

在 `\themes\next\layout\_macro` 目录下新建 `high.swig` 文件，添加以下内容：

```js
<a title="收藏到书签，偶尔High一下^_^" rel="alternate" class="mw-harlem_shake_slow wobble shake" href='javascript:(
    /*
     * Copyright (C) 2015 Rocko (rocko.xyz) <rocko.zxp@gmail.com>
     *
     * Licensed under the Apache License, Version 2.0 (the "License");
     * you may not use this file except in compliance with the License.
     
     * Unless required by applicable law or agreed to in writing, software
     * distributed under the License is distributed on an "AS IS" BASIS,
     * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     * See the License for the specific language governing permissions and
     * limitations under the License.
     */
    function go() {
    
      var songs = [
          "http://m2.music.126.net/3uHnH7uQAeFwUfuvEB9lrg==/3265549619475054.mp3", 
          "http://m2.music.126.net/NnHwR2HV-1OoKZ6R5LVy4Q==/18502581673300023.mp3",
          "http://m2.music.126.net/qv3RI4K7ABKJ0TyAdb3taw==/3250156397064860.mp3",    
          "......"
      ];
 
      function S() {
          var e = document.getElementById("audio_element_id");
          if(e != null){
              var index = parseInt(e.getAttribute("curSongIndex"));
              if(index > songs.length - 2) {
                  index = 0;
              } else {
                  index++;
              }
              e.setAttribute("curSongIndex", index);
          }
          e.src = i;
          e.play()
      }
      function initAudioEle() {
          var e = document.getElementById("audio_element_id");
          if(e === null){
            e = document.createElement("audio");
            e.setAttribute("curSongIndex", 0);
            e.id = "audio_element_id";
            e.loop = false;
            e.bgcolor = 0;
            e.innerHTML = " <p>If you are reading this, it is because your browser does not support the audio element. We recommend that you get a new browser.</p> <p>";
            document.body.appendChild(e);
            e.addEventListener("ended", function() {
              go();
            }, true);
          }        
      }
    
      initAudioEle();
      var curSongIndex = parseInt(document.getElementById("audio_element_id").getAttribute("curSongIndex"));
      var i = songs[curSongIndex];
      S();
    })()'>
    <i class="fa fa-music"></i>听音乐</a>
```

在侧边栏引用该文件：修改 `\themes\next\layout\_macro\sidebar.swig`，添加以下代码：

```
{% include 'high.swig' %}
```

样式修改：使 听音乐 和 RSS 并排展示。

修改 `\themes\next\source\css\_schemes\Pisces\_sidebar.styl` 文件：

```
display: inline-block;
```

添加自己喜欢的音乐：修改其中的歌曲链接即可.

```js
var songs = [
      "http://m2.music.126.net/3uHnH7uQAeFwUfuvEB9lrg==/3265549619475054.mp3", 
      "http://m2.music.126.net/NnHwR2HV-1OoKZ6R5LVy4Q==/18502581673300023.mp3",
      "http://m2.music.126.net/qv3RI4K7ABKJ0TyAdb3taw==/3250156397064860.mp3",    
      "......"
  ];
```

首页听音乐摇晃：需要加载 `css` 样式。在 `themes\next\layout\_layout.swig` 文件的 `</body>` 标签前 添加以下代码：

```html
<!-- 听音乐摇晃 -->
<link href="http://s3.amazonaws.com/moovweb-marketing/playground/harlem-shake-style.css" rel="stylesheet" type="text/css">
```

注意：有时候使用 Firefox 、Chrome时会提示非法插件并禁止使用，遇到这种情况我们把样式代码引入到 `\themes\next\source\css\_custom\custom.stly` 文件即可解决。

### 音乐链接获取

- 先获取歌曲id，直接打开 [网易云音乐网页版](http://music.163.com) 搜索自己喜欢的音乐，点击外链生成器获取歌曲的 ID 。举个例子：（id显而易见吧）

```
http://music.163.com/#/song?id=443205403
```

- 将下面网址中的两处id替换成的歌曲 id ，你将会获得一大串代码：外链就隐藏其中。
- http://music.163.com/api/song/detail/?id=425137664&ids=[425137664]&csrf_token=
- 将上一步中获取到的网址放到地址栏中，若能正常播放音乐说明获取到的网址是正确的。然后你就可以把这些歌曲添加到自己的网页中了！用这种方法有些歌曲并不能获得，不过时效很长（只要网易云能听）。

## 博文压缩

目前知道的有两个插件可以压缩博文，`hexo-all-minifier` 插件和 `gulp` 插件。`hexo-all-minifier` 虽然使用比较简单，而且也可以压缩图片，但是对文章缩进（输入法全拼模式下按 Tab）不支持，所以暂时使用 `gulp` 压缩手段。

### hexo-all-minifier 使用方法

安装 `hexo-all-minifier`，在站点的根目录下执行以下命令：

```
$ npm install hexo-all-minifier --save
```

`hexo g` 编译的时候就会自动压缩 HTML、JS、图片。详情参考插件介绍 [hexo-all-minifier](https://github.com/chenzhutian/hexo-all-minifier)

### glup 使用方法

`hexo` 依赖 `gulp` 插件安装，在站点的根目录下执行以下命令：

```
$ npm install gulp -g
$ npm install gulp-minify-css gulp-uglify gulp-htmlmin gulp-htmlclean gulp --save
```

在 `package.json` 同级目录下，新建 `gulpfile.js` 并填入以下内容：

```js
var gulp = require('gulp');
var minifycss = require('gulp-minify-css');
var uglify = require('gulp-uglify');
var htmlmin = require('gulp-htmlmin');
var htmlclean = require('gulp-htmlclean');
// 压缩 public 目录 css
gulp.task('minify-css', function() {
    return gulp.src('./public/**/*.css')
        .pipe(minifycss())
        .pipe(gulp.dest('./public'));
});
// 压缩 public 目录 html
gulp.task('minify-html', function() {
  return gulp.src('./public/**/*.html')
    .pipe(htmlclean())
    .pipe(htmlmin({
         removeComments: true,
         minifyJS: true,
         minifyCSS: true,
         minifyURLs: true,
    }))
    .pipe(gulp.dest('./public'))
});
// 压缩 public/js 目录 js
gulp.task('minify-js', function() {
    return gulp.src('./public/**/*.js')
        .pipe(uglify())
        .pipe(gulp.dest('./public'));
});
// 执行 gulp 命令时执行的任务
gulp.task('default', [
    'minify-html','minify-css','minify-js'
]);
```

生成博文是执行 `hexo g &amp;&amp; gulp` 就会根据 `gulpfile.js` 中的配置，对 `public` 目录中的静态资源文件进行压缩。

## 博文置顶

### 修改 hexo-generator-index 插件

替换文件：`node_modules/hexo-generator-index/lib/generator.js` 内的代码为：

```js
'use strict';
var pagination = require('hexo-pagination');
module.exports = function(locals){
  var config = this.config;
  var posts = locals.posts;
    posts.data = posts.data.sort(function(a, b) {
        if(a.top && b.top) { // 两篇文章top都有定义
            if(a.top == b.top) return b.date - a.date; // 若top值一样则按照文章日期降序排
            else return b.top - a.top; // 否则按照top值降序排
        }
        else if(a.top && !b.top) { // 以下是只有一篇文章top有定义，那么将有top的排在前面（这里用异或操作居然不行233）
            return -1;
        }
        else if(!a.top && b.top) {
            return 1;
        }
        else return b.date - a.date; // 都没定义按照文章日期降序排
    });
  var paginationDir = config.pagination_dir || 'page';
  return pagination('', posts, {
    perPage: config.index_generator.per_page,
    layout: ['index', 'archive'],
    format: paginationDir + '/%d/',
    data: {
      __index: true
    }
  });
};
```

### 设置文章置顶

在文章 Front-matter 中添加 top 值，数值越大文章越靠前，如：

```
---
title: 图集
categories: [图片]
tags: [picture]
date: 2015-04-02 14:36:04
top: 10
---
```

## Hexo 更改默认 Google 字体库

因为一些国内的客观原因，google 字体库 的访问速度一直很慢，所以生成页面后，访问系统总是会耗费一大部分的时间在加载 google 字体库上，而且经常加载不成功。

解决的办法是可以用国内的 CDN 库来替代主题中的 google 字体库，更改方法如下：

shell 中运行如下命令：

```
grep -ir fonts.google themes/
```

找到对应的 google 字体库地方，用国内的 CDN 字体库替换，如 360 字体库：[360 前端公共库 CDN](http://libs.useso.com/)。

## 首页分割线

在 `\themes\next\source\css\_custom\custom.styl` 文件中添加以下代码，可以修改博客首页中每篇文章的分割线长度，我设置为了100%长度。

```css
//index页面中每篇文章相隔的那条线
.posts-expand {
  .post-eof {
    display: block;
    margin: $post-eof-margin-top auto $post-eof-margin-bottom;
    width: 100%;
    height: 3px;
    background: $grey-light;
    text-align: center;
  }
}
```

## 字体、颜色等设置

在 `\themes\next\source\css\_variables\custom.styl` 文件中添加以下代码。具体功能我已经做了注释。

```
// 标题，修改成你期望的字体族
$font-family-headings = Georgia, sans

// 修改成你期望的字体族
$font-family-base = "Microsoft YaHei", Verdana, sans-serif

// 代码字体
$code-font-family = "Input Mono", "PT Mono", Consolas, Monaco, Menlo, monospace

// 正文字体的大小
$font-size-base = 16px

// 代码字体的大小
$code-font-size = 14px

// 代码块颜色
$code-foreground = #dd0055

// Background color for <body>
$body-bg-color = #e7e5dc  //theme mist use #fdfdfd

// text-color
$text-color = #353535
```

- 本文部分内容整理自博文 [HEXO+GitHub 搭建博客 - 优化](http://www.cwyaml.top/2017/01/25/hexo2/)，在此表示感谢。
