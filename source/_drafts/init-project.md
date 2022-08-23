---
title: 从零开始初始化 React + TypeScript 技术栈项目
tags: [React, Redux, TypeScript, pnpm, ]
categories: [项目实战]
date: 2022-08-13 16:00:00
---

在学习框架搭建项目的时候，有 create-react-app 和 vue-cli 这种脚手架，在公司里有项目模板，所以一般情况下不需要我们从零开始初始化配置一个项目。但有些东西还是知道的好，所以今天我们一起初始化一个 React + TypeScript 技术栈的前端项目吧。

## 环境配置

### 安装 Node

一般程序员电脑上应该都装了 Node，没安装的话去 Node 官网 https://nodejs.org/ 按照官方指引安装即可。

打开我们电脑的命令行工具，按照下图输入对应的命令查看 Node 和 npm 版本，如果都能查看，那你应该就安装成功了。

<!-- more -->

![image-20220813130023035](https://images.dingxuewen.com/20220813130023image-20220813130023035.png)

### 安装 pnpm

我这里使用 npm 的方式安装，如果你安装过了请忽略：

```shell
npm install -g pnpm
```

如果你需要采用其他方式安装，请按照官网提示查找对应方式：https://pnpm.io/installation

### 项目初始化

```shell
# 创建文件夹
mkdir project-name
# 进入文件夹
cd project-name
# 用 pnpm 初始化项目，会生成 package.json 和 pnpm-lock.yaml 文件
pnpm init
```

### 安装 React 和 React-DOM 依赖

```shell
# 安装 react 和 react-dom
pnpm add react && pnpm add react-dom
# 如果你需要 Redux，就安装
pnpm add redux
```

### 安装 TypeScript

```shell
# 以 devDependencies 的方式安装 TypeScript
pnpm add typescript -D
```

### 安装 React 和 React-DOM 等的类型

```shell
pnpm add @types/react -D && pnpm add @types/react-dom -D && pnpm add prop-types -D
```

### 初始化 TypeScript 配置

```shell
# 生成 tsconfig.json 文件
tsc --init
# 如果上面的命令行执行失败，可能是你没全局安装 typescript，那全局安装一下再重新执行上一行的命令
npm install typescript -g
```

之后打开 `tsconfig.json` 文件，想去中添加一个 `include` 告诉 TypeScript 需要编译哪些代码：

```shell
{
    "compilerOptions": {
    	...
    },
    "include":[ 
        "./src/**/*"
    ]
}
```

至于更详细的  `tsconfig.json` 配置，可以搜索一些推荐配置并根据项目实际需要进行配置，在此不详细展开。

### 安装 Webpack 和相关依赖

```shell
# 安装 Webpack 和相关工具
pnpm add webpack -D
# 在终端提供 Webpack 命令
pnpm add webpack-cli -D
# 提供服务端能力，dev server
pnpm add webpack-dev-server -D
# 使用 tsconfig 帮助 Webpack 编译我们的 TypeScript 代码
pnpm add awesome-typescript-loader -D
# 简化 HTML 文件的创建以提供 Webpack 打包
pnpm add html-webpack-plugin -D
```

然后在项目根目录创建 `webpack.config.js` 文件：

```js
const path = require('path');
const HtmlWebPackPlugin = require('html-webpack-plugin');

module.exports = {
    entry: {
        app: ['./src/App.tsx'],
        vendor: ['react', 'react-dom']
    },
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'js/[name].bundle.js'
    },
    devtool: "source-map",
    resolve: {
        extensions: [".ts", ".tsx", ".js", ".jsx", ".json"]
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                loader: "awesome-typescript-loader"
            }
        ]
    },

    plugins: [
        new HtmlWebPackPlugin({
            template: "./src/index.html"
        })
    ]
};
```



