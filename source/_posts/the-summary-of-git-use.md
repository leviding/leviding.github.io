---
title: 近期 Git 使用小结(包括同时同步两个仓库)
tags: [Git]
categories: [开发总结]
date: 2017-03-04 14:48:10
---

## 本地新建项目

 1. 第一步需要你在 GitHub 等代码托管平台创建一个新的项目，（本文以 GitHub 为例）。
 2. 在本地新建一个文件夹例如在F盘新建了一个名为 `test`，然后用 `cmd` 或 `Git Bash` 等，输入 `f:`，这样进入到了 F 盘，再输入 `cd test` 则进入到了 `path 文件夹`。
 3. 接着按照下面的代码依次输入每一行代码，输完一行回车一下，即可完成为本地文件夹和远程的链接，以及为项目新建并上传一个 README.md 文件。
 4. 注：要把 `git remote add origin ***` 这句改成你自己项目的 ssh，我写的这个是我的，你是上传不上去的。

<!-- more -->

```
git init
echo "# path" >> README.md
git add README.md
git commit -m "first commit"
git remote add origin https://git.coding.net/Dingxuewen/test.git
git push -u origin master
```


## 上传本地已有项目

 1. 第一步需要你在 GitHub 等代码托管平台创建一个新的项目（本文以 GitHub 为例）。
 2. 假设你的项目存在 F 盘名为 `test` 的文件夹中，然后用 `cmd` 或 `git Bash` 等，输入 `f:`，这样进入到了 F 盘，再输入 `cd test` 则进入到了`test 文件夹`。
 3. 接下来依次输入下面的每一行代码，输完一行回车一下，即可完成本地项目与托管平台的链接和项目的上传。
 4. 注：要把 `git remote add origin ***` 这句改成你自己项目的 `ssh`，我写的这个是我的 `ssh`，你是上传不上去的。如果本地文件夹没有 `.git`，记得输入 `git init` 生成 `.git` 文件夹。如果你是小白，在这个过程中估计会有不少困难，建议认真看看[廖雪峰的 Git 教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)，廖老师的教程通俗易懂，葵花宝典哈哈。

```
git remote add origin https://git.coding.net/Dingxuewen/test.git
git push -u origin master
```


## 项目同时上传 GitHub 和 Coding

此处我只是以 GitHub 和 Coding 为例子，当然还有很多其他的版本控制平台，例如 GitLab、GitBucket 和码云等等。做到这我就默认你的项目已经有 `.git` 文件夹啦（这个文件夹是隐藏的，要勾选隐藏的项目才能将其显示出来）。如下图：

![](https://i.loli.net/2018/05/21/5b02320fbacd1.png)

**那么现在我们就开始吧！**


### 第一步：修改config文件

例如我将 F 盘名为 `test` 的文件夹中的文件同步 GitHub 和 Coding 中。那么先修改 `\.git\config` 文件。打开 `config` 文件，修改如下（里面具体的 `url` 修改成你要同步到的远程项目，此处是我的）：

```
[remote "origin"]
	url = git@github.com:Dingxuewen/test.git
	url = git@git.coding.net:Dingxuewen/test.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
```


### 第二步：文件上传

关闭修改好的文件，用 `cmd` 或 `Git Bash` 等，输入 `f:`，这样进入到了F 盘，再输入 `cd test` 则进入到了`test 文件夹`。接下来依次输入下面的每一行代码，输完一行回车一下，即可完成本地项目与托管平台的链接和项目的上传。
注：`git add *` 是 add 项目中所有文件，那么如果你想 add 某些文件则把星号改成相应文件名即可。
**在此处我主要是想用本地项目覆盖远程项目文件。**

```
git add *
git commit -m 'test'
git push origin master
```


### 第三步：易出现的错误

若出现下面这样的错误：

```
To git.coding.net:Dingxuewen/test.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'git@git.coding.net:Dingxuewen/test.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

![](https://i.loli.net/2018/05/21/5b02321787834.png)

则输入 `git push -f` 即可，如下图：

![](https://i.loli.net/2018/05/21/5b02321f9e1e6.png)


### 第四步：以后更新

以后更新内容，只需要以下几步。

```
#cd your path
git add *  //我这句是添加所有本地更新，你也可以添加某些文件
git commit -m 'commit message'
git push origin master
```

最后成功的效果如下图：

![](https://i.loli.net/2018/05/21/5b02322ac7b45.png)

好啦，这次的分享到此为止，等我再有心得体会的时候再和大家分享跟多的内容。

Happy Coding！
