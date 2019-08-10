# LeviDing's Blog

[![Build Status](https://travis-ci.org/leviding/leviding.github.io.svg?branch=source)](https://travis-ci.org/leviding/leviding.github.io)

本项目用于托管 [LeviDing 的博客](https://dingxuewen.com/)，博客源码托管在 [source 分支](https://github.com/leviding/leviding.github.io/tree/source)，当 [Travis CI](https://www.travis-ci.org) 监测到 [source 分支](https://github.com/leviding/leviding.github.io/tree/source)的变化时，自动将博客部署到 [master 分支](https://github.com/leviding/leviding.github.io/tree/master)。

## 在线阅读和开发

基于 VuePress

```bash
// 安装
$ yarn

// 更新
$ yarn upgrade

// 清除缓存
$ hexo clean

// 构建静态文件
$ hexo g

// 本地运行预览
$ hexo s

// 一键运行和部署
$ yarn d
```
