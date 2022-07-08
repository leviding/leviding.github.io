# LeviDing's Blog

[![Build Status](https://travis-ci.org/leviding/leviding.github.io.svg?branch=source)](https://travis-ci.org/leviding/leviding.github.io)

本项目用于托管 [LeviDing 的博客](https://dingxuewen.com/)，博客源码托管在 [source 分支](https://github.com/leviding/leviding.github.io/tree/source)，当 [GitHub Action](https://github.com/leviding/leviding.github.io/actions/workflows/hexo-deploy.yml) 监测到 [source 分支](https://github.com/leviding/leviding.github.io/tree/source)的变化时，自动将博客部署到 [master 分支](https://github.com/leviding/leviding.github.io/tree/master)。

<!--
**参考文章：**

> - [Github & Travis CI & Hexo 实现博客自动部署](https://michael728.github.io/2019/06/16/cicd-hexo-blog-travis/)
> - [Hexo 遇上 Travis-CI](https://juejin.im/post/5a1fa30c6fb9a045263b5d2a)
> - [SEO 优化](https://hoxis.github.io/Hexo+Next%20SEO%E4%BC%98%E5%8C%96.html)
-->


## 本地阅读和开发

基于 Hexo

```bash
// 安装
$ yarn

// 更新
$ yarn upgrade

// 清除缓存
$ hexo clean

// 构建静态文件
$ hexo g

// 爬取豆瓣读书信息并生成静态文件
$ hexo douban -b

// 爬取豆瓣影视信息并生成静态文件
$ hexo douban -m

// 本地运行预览
$ hexo s

// 一键运行和部署，因进行了 GITHUB_TOKEN 加密，故本地部署需输入 TOKEN
// 此命令执行 deploy.sh 脚本
$ yarn deploy
```


## 博客撰写和部署

```
// Clone 到本地
$ git clone git@github.com:leviding/leviding.github.io.git

// 进入文件夹
$ cd leviding.github.io

// 提交 GitHub
$ git add -A
$ git commit -m "xxxxxx"
$ git push original source

// 如果本地安装了 yarn，可通过一个命令直接提交
// 此命令行执行 gitpush.sh 脚本
$ yarn push
```


## 微信公众号

欢迎微信扫码关注我的公众号

| 技术号：技术漫谈 | 技术号：编程每日一题 | 个人号：丁学文 |
| :----: | :----: | :----: |
| <img src="https://user-images.githubusercontent.com/26959437/67535623-0955e780-f706-11e9-971d-eb418c392957.jpg" width="200px"> | <img src="https://user-images.githubusercontent.com/26959437/177953257-6f822877-320b-4950-a6c0-e821c25b51ba.jpg" width="200px"> | <img src="https://user-images.githubusercontent.com/26959437/177953236-594ac348-4616-4ae4-aa99-e14d96eb6540.jpg" width="200px"> |


## Contact Me

Mail: [imdingxuewen@gmail.com](mailto:imdingxuewen@gmail.com)

---

> Blog: [dingxuewen.com](https://dingxuewen.com/) &nbsp;&middot;&nbsp;
> GitHub: [@LeviDing](https://github.com/leviding) &nbsp;&middot;&nbsp;
> Twitter: [@LeviDing](https://twitter.com/xuewending)
