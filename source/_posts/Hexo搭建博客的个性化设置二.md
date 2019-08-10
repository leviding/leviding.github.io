---
title: Hexo 搭建博客的个性化设置二
tags: [Hexo, Next, Site]
categories: [项目实战]
date: 2017-03-03 23:21:32
---

## 在标题下添加「阅读量」等

在 [Hexo 搭建博客的个性化设置一](http://www.dingxuewen.com/article/Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2%E7%9A%84%E4%B8%AA%E6%80%A7%E5%8C%96%E8%AE%BE%E7%BD%AE%E4%B8%80/)这篇文章中讲到添加不蒜子等数据统计功能，那么再者就是对数据的显示进行个性化设置。上一篇文章中有一段 JS 代码：

```js
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js">
</script>
```

<!-- more -->

现在要添加的阅读量统计也依赖这段代码，上面已经将它添加到页面中，这里可以直接调用它。

打开 `/themes/next/layout/_macro/post.swig，找到标签 <div class="post-meta"></div>`，在该标签内部合适的位置（如 `time` 和 `categroies` 之间或 `categroies` 后面）添加：

```js
{% if not is_index %}
  <span id="busuanzi_container_page_pv">&nbsp;&nbsp;|&nbsp;&nbsp;阅读量 <span id="busuanzi_value_page_pv"></span> 次</span>
{% endif %}
```

当然如果你不是用的不蒜子统计也没关系，对上面几句代码进行灵活变通即可，不明白可以发邮件给我。

## 将阅读量改为热度（更个性）

还可以继续修改，看到好多人的博客不是阅读次数（阅读量），而是 xxx 度，那么可以继续这样修改，首先在 Next 主题的 `/themes/next/languages/zh-Hans` 文件中查找”阅读次数“这几个字，可以看到，在 `post` 中的 `visitors` 被定义为“阅读次数”，把这里的“阅读次数”改为“热度”。

那么怎么在页面中显示呢。打开 Next 主题文件夹中 `layout/_macro/post.swig`，在这个文件里加上摄氏度的标志，在 `<span class="leancloud-visitors-count"></span>` 下面增加一行 `<span>℃</span>` 即可。

## 修改标题下分类等的样式

在 Next 主题中，我用的是 LeanCloud 数据统计，默认样式是在统计数据前有个小眼睛，我感觉不好看，想把它去掉，那么打开 `/themes/next/layout/_macro/post.swig`，找到标签 `<i class="fa fa-eye"></i>`，去掉下面这段代码即可：

```html
<span class="post-meta-item-icon">
  <i class="fa fa-eye"></i>
</span>
```

## 增加留言页

那么有人会问，你的 guestbook 是如何创建的，那么现在我就把方法写出来。

新建一个 guestbook 页面：
在你的站点文件夹，用 shell 等运行下面这行代码：

```
hexo new page "guestbook"
```

找到你NexT主题 `_config.yml`（主意是 Next 主题的 `_config.yml`，不是 hexo 站点目录下的 `_config.yml`），文件路径 `\themes\next\_config.yml`，添加 `guestbook` 到 `menu` 中，如下:

```
menu:
  home: /
  #categories: /categories
  about: /about
  archives: /archives
  # tags: /tags
  #commonweal: /404.html
  guestbook: /guestbook
```

找到你Next主题 `zh-Hans.yml` 文件（我的网站是简体语言的），文件路径 `\themes\next\languages\zh-Hans.yml`，添加 `guestbook: 留言板` 到 `menu` 中，如下:

```
menu:
  home: 首页
  archives: 归档
  categories: 分类
  tags: 标签
  about: 关于
  commonweal: 公益404
  guestbook: 留言
```

## SEO 优化

更改首页标题格式为「关键词-网站名称-网站描述」。打开 `\themes\next\layout\index.swig` 文件，找到这行代码：

```js
{% block title %} {{ config.title }} {% endblock %}
```

把它改成：

```js
{% block title %}
  {{ theme.keywords }} - {{ config.title }} - {{ theme.description }}
{% endblock %}
```

## 博客部署的 message 设置

在 `\hexo\node_modules\hexo-deployer-git\lib\deployer.js` 文件末尾找到这一句：

```
Site updated: {{ now('YYYY-MM-DD HH:mm:ss') }}.
```

改得个性化一点：

```
勤奋的博主又更新啦: {{ now(\'YYYY-MM-DD HH:mm:ss\') }}.
```

## 为项目主页添加 README

在 Github 上的博客仓库主页空荡荡的，没有 `README`。如果把 `README.md` 放入 `source` 文件夹，hexo g 生成时会被解析成 html 文件，放到public文件夹，生成时又会自动删除。

解决方法很简单，在站点配置文件中，搜索 `skip_render:`，在其冒号后加一个空格然后加上 `README.md` 即可。
