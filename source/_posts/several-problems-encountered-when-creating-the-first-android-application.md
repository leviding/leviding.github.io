---
title: 使用 Android Studio 创建第一个 APP 时遇到的几个问题
tags: [Android, Gradle, 小米]
categories: [开发配置]
date: 2017-06-01 02:30:30
---

2013 年 5 月 16 日，在 I/O 大会上，谷歌推出新的 Android 开发环境 —— Android Studio，并对开发者控制台进行了改进，增加了五个新的功能。Android Studio 是一个 Android 集成开发工具，基于 IntelliJ IDEA。类似 Eclipse ADT，Android Studio 提供了集成的 Android 开发工具用于开发和调试。

<!-- more -->

本文记录了我在搭建 Android 开发环境和发布第一个 APP 的过程中遇到的问题，防止今后再遇到此类问题，同时也将这些问题的解决方案分享给大家，Android 我来啦！


## 问题一

当你使用 Android Studio 创建项目时，在项目导入的过程中，一直卡在 `Building gradle project info` 这一步，那么出现这种问题是因为国外网站被墙了。即使你开了 VPN，那这一步所需要的等待时间也是非常人所能忍受，我就是开了 VPN 的，因为 Gradle 官网虽然可以访问，但是速度连蜗牛都赶不上...

![](https://i.loli.net/2018/05/21/5b0234100b1b8.png)


### 解决方法

#### 下载 `gradle` 离线包

查看所需 `gradle` 版本：打开 `C:\Users\用户名\.gradle\wrapper\dists\gradle-x.xx-all\xxxxxxxxxxxx`，如果里面的 `gradle-xx-all.zip` 不完整（如 `0KB`），则说明下载不成功，需要下载离线包放置到该目录下。如下图所示：

![](https://i.loli.net/2018/05/21/5b02341a7413e.png)

那么，则需要下载 `gradle-2.8-all.zip`。`gradle` 各个版本离线包国内下载地址：http://download.csdn.net/album/detail/2265 。下载好以后，你直接把压缩包放到这个文件夹就可以了，不要解压！当你运行 Android Studio 的时候会自动解压。如下图所示，这时候你再重新打开项目就会发现卡住的问题已经解决了。

![](https://i.loli.net/2018/05/21/5b02342acfa19.png)


#### 修改项目 `gradle` 版本

修改项目 `gradle-wrapper.properties` 里的 `gradle` 版本为自己电脑已有的 `gradle` 版本（如果你是第一次安装 Android Stidio，那么你的电脑里应该没有其他版本的 gradle，所以你应该使用方法一来解决你的这个问题）。

修改 `gradle-wrapper.properties` 方式：

1. 随便找一个你之前能够运行的 Android Stidio 项目
2. 打开项目的 `/gradle/wrapper/gradle-wrapper.properties` 文件
3. 复制最后一行 `distributionUrl` 这一整行的内容，例如： `distributionUrl=https\://services.gradle.org/distributions/gradle-2.8-all.zip`，替换到你要导入的项目里的 `gradle-wrapper.properties` 文件中。
4. 重启 Android Studio，重新导入项目就可以了~~


## 问题二

当你编写了一点程序，想要在手机上进行测试，你把相关设置都弄好了，但是仍然提示一个 "No target device found." 的错误。


### 解决方法

其实这是在 Android Studio 初始化的过程中，Android Monitor 程序没被启动而无法识别USB线所连接的设备所致。解决方法很简单： 点击下方的 Android Mointor 选项，Android Studio 会帮你自动识别查找设备，这样就完美的解决了这个问题。

![](https://i.loli.net/2018/05/21/5b0295d6c0c3d.jpg)


## 问题三

当你以上问题都解决好了，想要将 APP 下载到手机里试一试，但是这时候调度程序时给你了这样的提示：“Installation failed with message Failed to establish session”。


### 解决方法

这时候你赶紧检查下自己是否使用的是小米手机，是的话，在开发者选项里关闭 MIUI 优化即可！


## 问题四

你想把自己写的 APP 发给小伙伴，让他们安装使用，但是你的 APP 安装在他们手机上却打不开，一直闪退。


### 解决方法

1. 把 Android Studio 的 Instant Run 给关掉，File → Settings → Build,Execution,Deployment → Instant Run 如图:

![](https://i.loli.net/2018/05/21/5b0234352a670.png)

**注意**：应该在 `Project` 状态下进行设置。

2. 然后把所有生成缓存清除掉：即删除 build 文件，如下图：

![](https://i.loli.net/2018/05/21/5b02343e847df.png)

- `Clear Project` 清理一下项目，然后重新运行项目。

![](https://i.loli.net/2018/05/21/5b02344736e82.png)

> 注意：apk 文件存放于 app → build → outputs → apk 目录下。
