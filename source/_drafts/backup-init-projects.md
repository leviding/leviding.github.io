## 前言

现在我们开发一个 React 项目最快的方式便是使用 Facebook 官方开源的脚手架 [create-react-app](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Ffacebook%2Fcreate-react-app) ，但是随着业务场景的复杂度提升，难免会需要我们再去添加或修改一些配置，这个时候如果对 webpack 不够熟练的话，会比较艰难，那种无力的感觉，就好像是女朋友在旁边干扰你打游戏一样，让人焦灼且无可奈何。

这篇文章的主要目的是让大家（新手）对** webpack 构建 react + typescript 项目开发环境 **有一个很感性的认知，以及 **会配合使用 rollup 打包组件并发布至 npm 全流程**，坦白说，相关的文章真的很多了，但是我仍然想再写一篇属于我自己风格的文章，什么风格呢？

> 1.从零开始搭建至完整的项目开发环境流程！
>  2.尽量做到每一步操作、每一行代码都能尽量解释给读者！
>  3.若完全跟着做下来，一定能实现同样的功能！

## 你能学到什么？

希望在你阅读本篇文章之后，不会觉得浪费了时间。如果你跟着读下来，你将会学到：

- 🍋 项目中常用配置文件的作用及配置方式
- 🍊 eslint、stylelint 及 prettier 的配置
- 🍉 代码提交规范的第三方工具强制约束方式实现
- 🍓 webpack 配置 react + typescript 开发与生产环境及优化
- 🍑 rollup 构建组件打包环境并发布至 npm 的全流程
- 🍏 利用 react-testing-library 对 react 组件进行测试
- 🥝 持续集成（CI）、Github Actions

## 项目初始化及配置

大家对 github 一定很熟悉了，各式各样的开源工具一定也是经常被大家用到，用久了自己也想对开源社区做一些贡献，奈何各种配置太过繁琐，劝退了一大部分热心的开发者，我当初就是有很多想法，但是只会写代码，看别人的开源项目一堆配置文件，看的头皮发麻，再想想自己全都看不懂，想想就算开发出来了，别人也会觉得不专业，就抱着这种心态直接放弃了～

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cfa18f97495e41deb3c1c9ccd5730755~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

别慌，看完这篇文章，该会的都会了！ 那我们现在就从 github 新建一个开发脚手架项目开始吧～

这一步只需要在 github 主页右上角点击“+”然后 `New repository` 之后进行项目名字及项目描述的填写，选择一个开源协议即可确定创建完成（比如我新建的一个项目便为 [react-ts-quick-starter](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fvortesnail%2Freact-ts-quick-starter) ，欢迎大家 pr 以及 star🌟。），进入到项目主页之后，点击绿油油的 `Code` 大按键，复制 SSH 链接，回到我们的桌面，打开终端（控制台），切换到你想要的目录下，执行命令：

```bash
# 注意以下的 ssh 连接要是自己项目下复制的
git clone git@github.com:vortesnail/react-ts-quick-starter.git
复制代码
```

当 clone 完成之后，使用编辑器打开项目文件夹，我们的 vscode 该上场了！ 我个人比较习惯于使用 vscode 自带的终端，打开默认的终端快捷键为 `ctrl + 反引号` ，当前目录默认就为项目目录。

### 1. package.json

每一个项目都需要一个 `package.json` 文件，它的作用是记录项目的配置信息，比如我们的项目名称、包的入口文件、项目版本等，也会记录所需的各种依赖，还有很重要的 `script` 字段，它指定了运行脚本命令的 `npm` 命令行缩写。

通过以下命令就能快速生成该文件：

```bash
npm init -y
```

你也可以使用 `yarn` 来进行生成，但是我个人还是对 `npm` 更习惯些，所以我之后都会用 `npm` 来进行依赖包的安装。

通过修改生成的默认配置，现在的内容如下：

```json
{
  "name": "react-ts-quick-starter",
  "version": "1.0.0",
  "description": "Quickly create react + typescript project development environment and scaffold for developing npm package components",
  "main": "index.js",
  "scripts": {},
  "repository": {
    "type": "git",
    "url": "git+https://github.com/vortesnail/react-ts-quick-starter.git"
  },
  "keywords": ["react-project", "typescript-project", "react-typescript", "react-ts-quick-starter"],
  "author": {
    "name": "vortesnail",
    "url": "https://github.com/vortesnail",
    "email": "1091331061@qq.com"
  },
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/vortesnail/react-ts-quick-starter/issues"
  },
  "homepage": "https://github.com/vortesnail/react-ts-quick-starter#readme"
}
```

暂时修改了以下配置：

- `description` ：增加了对该项目的描述，github 进行 repo 搜索时，关键字匹配会使你的项目更容易被搜索到。
- `scripts` ：把默认生成的删了，没啥用。
- `keywords` ：增加了项目关键字，其他开发者在 npm 上搜索的时候，适合的关键字能你的包更容易被搜索到。
- `author` ：添加了更具体的作者信息。
- `license` ：修改为[MIT](https://link.juejin.cn?target=https%3A%2F%2Fopensource.org%2Flicenses%2FMIT)协议。

### 2. LICENSE

我们在建仓库的时候会有选项让我们选择开源协议，我当时就选了MIT协议，如果没选的也不要紧，去网站  [choosealicense](https://link.juejin.cn?target=http%3A%2F%2Fchoosealicense.online%2F) 选择合适的 license（一般会选宽松的 MIT 协议），复制到项目根目录下的 `LICENSE` 文件内即可，然后修改作者名和年份，如下：

```sql
MIT License

Copyright (c) 2020 chen xin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights...
```

### 3. .gitignore

该文件决定了项目进行 git 提交时所需要忽略掉的文件或文件夹，编辑器如 vscode 也会监听 `.gitignore` 之外的所有文件，如果没有进行忽略的文件有所变动时，在进行 git 提交时就会被识别为需要提交的文件。

`node_modules` 是我们安装第三方依赖的文件夹，这个肯定要添加至 `.gitignore` 中，且不说这个文件夹里面成千上万的文件会给编辑器带来性能压力，也会给提交至远端的服务器造成不小损失，另外就是这个文件夹中的东西，完全可以通过简单的 `npm install` 就能得到～

所以不需要上传至 git 仓库的都要添加进来，比如我们常见的 `build` 、 `dist` 等，还有操作系统默认生成的，比如 MacOs 会生成存储项目文件夹显示属性的 `DS_Store` 文件。

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4572f718999048ce8bf8d1ffbd4f7026~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

那么这些系统或编辑器自动生成的文件，但是又不被我们很容易查知的该怎么办呢？使用 vscode 的 [gitignore](https://link.juejin.cn?target=https%3A%2F%2Fmarketplace.visualstudio.com%2Fitems%3FitemName%3Dcodezombiech.gitignore) 插件，下载安装该插件之后， `ctrl+shift+p` 召唤命令面板，输入 `Add gitignore` 命令，即可在输入框输入系统或编辑器名字，来自动添加需要忽略的文件或文件夹至 `.gitignore` 中。

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d050bf85521f45818aae0d01d1eafef4~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

我添加了以下：  `Node` 、 `Windows` 、 `MacOS` 、 `SublimeText` 、 `Vim` 、 `Vscode` ，大家酌情添加吧。如果默认中没有的，可自行手动输入至 `.gitignore` 中，比如我自己加了 `dist/` 和 `build/` ，用于忽略之后webpack 打包生成的文件。

### 4. .npmrc

大家一开始使用 npm 安装依赖包时，肯定感受过那挤牙膏般的下载速度，上网一查只需要将 npm 源设置为淘宝镜像源就行，在控制台执行一下以下命令：

```bash
npm config set registry https://registry.npm.taobao.org
复制代码
```

从此过上了**速度七十迈，心情是自由自在**的生活。

但是大家想想，万一某个同学克隆了你的项目之后，准备在他本地开发的时候，并没有设置淘宝镜像源，又要人家去手动设置一遍，我们作为项目的发起者，就先给别人省下这份时间吧，只需要在根目录添加一个 `.npmrc` 并做简单的配置即可：

```bash
# 创建 .npmrc 文件
touch .npmrc
# 在该文件内输入配置
registry=https://registry.npm.taobao.org/
```

### 5. README.md

你只要上 github 找任何一个项目，点进去之后往下拉一点，看到的对项目的直接说明就是 `README.md` 所呈现的，这个文件无比重要，一个好的开源项目必须！必须！必须！有一个简明且美观的 `README.md` ，不过文章写到现在为止，我们的这个脚手架并没有任何实质性的内容，之后完全配置完之后，会再好好书写一下。

后续我还会再对这部分内容做补充，现在大家先 `touch README.md` 创建文件，然后随意写点东西先看着～

## 规范代码与提交

多人共同开发一个项目的很大问题就是每个开发者代码风格都有所差异，随着版本不断迭代，维护人员不断更换，这个项目将会变得越来越难维护，因为后人基本不可能再看懂了。比如小迈、小克、小尔三个开发者的风格如下：

```javascript
// 小迈 紧凑型
const add=(a,b)=>{
  return a+b;
}

// 小克 规范型
const add = (a, b) => {
    return a + b
}

// 小尔 松紧皆可型
var add = (a,b) => {
  return a+b
}
```

请问如果你刚加入一个团队，所要参与的项目中有这几种代码风格，你会不会觉得“**人间不值得”**？

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f6c607dcb42943bb88c4ce0553379839~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

如果我们一开始就有手段能够约束大家的代码风格，使其趋于统一，将会极大地增强代码的可维护性，很重要的一点是能提高我们开发的幸福度。

当然了，作为开源项目，代码的提交规范也是很有必要遵守的，这个我们也可以通过第三方工具来强制约束，不要太美滋滋啊，既能使项目的提交更加规范，还能不断地锻炼自己的**规范性思维，**这对于无论是开源项目还是团队项目，都是大有裨益的。

### 1. EditorConfig

`.editorconfig` 是跨编辑器维护一致编码风格的配置文件，有的编辑器会默认集成读取该配置文件的功能，但是 vscode 需要安装相应的扩展 [EditorConfig For vs Code](https://link.juejin.cn?target=https%3A%2F%2Fmarketplace.visualstudio.com%2Fitems%3FitemName%3DEditorConfig.EditorConfig) 。

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/864a2298b334401da91ba7e901a9e283~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

安装完此扩展后，在 vscode 中使用快捷键 `ctrl+shift+p` 打开命令台，输入 `Generate .editorcofig` 即可快速生成 `.editorconfig` 文件，当然，有时候 vscode 抽风找不到命令也是可能的，比如我就经常遇到输入该命令没用，需要重启才会重新出现，那么就手动创建该文件也是没问题的。

该文件的配置特别简单，就少许的几个配置，比如我的配置如下：

```ini
root = true

[*]
indent_style = space
indent_size = 2
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
end_of_line = lf

[*.md]
trim_trailing_whitespace = false
复制代码
```

扩展装完，配置配完，编辑器就会去首先读取这个配置文件，对缩进风格、缩进大小在换行时直接按照配置的来，在你 `ctrl+s` 保存时，就会按照里面的规则进行代码格式化。以下是上述配置的简单介绍：

- `indent_style` ：缩进风格，可选配置有 `tab` 和 `space` 。
- `indent_size` ：缩进大小，可设定为 `1-8` 的数字，比如设定为 `2` ，那就是缩进 `2` 个空格。
- `charset` ：编码格式，通常都是选 `utf-8` 。
- `trim_trailing_whitespace` ：去除多余的空格，比如你不小心在尾巴多打了个空格，它会给你自动去掉。
- `insert_final_newline` ：在尾部插入一行，个人很喜欢这个风格，当最后一行代码很长的时候，你又想对该行代码比较靠后的位置编辑时，不要太好用哦，建议大家也开上。
- `end_of_line` ：换行符，可选配置有  `lf` ，`cr` ，`crlf` ，会有三种的原因是因为各个操作系统之间的换行符不一致，这里有历史原因，有兴趣的同学自行了解吧，许多有名的开源库都是使用 `lf` ，我们姑且也跟跟风吧。

因为 `markdown` 语法中，我想要换行需要在上一行多打 2 个以上的空格，为了不影响该语法，故 `.md` 文件中把**去除多余空格**关掉了。

### 2. Prettier

如果说 `EditorConfig` 帮你统一编辑器风格，那 `Prettier` 就是帮你统一项目风格的。 `Prettier` 拥有更多配置项（实际上也不多，数了下二十个），且能在发布流程中执行命令自动格式化，能够有效的使项目代码风格趋于统一。

在我们的项目中执行以下命令安装我们的第一个依赖包：

```bash
npm install prettier -D
复制代码
```

安装成功之后在根目录新建文件 `.prettierrc` ，输入以下配置：

```json
{
  "trailingComma": "all",
  "tabWidth": 2,
  "semi": false,
  "singleQuote": true,
  "endOfLine": "lf",
  "printWidth": 120,
  "bracketSpacing": true,
  "arrowParens": "always"
}
复制代码
```

其实 `Prettier` 的配置项很少，大家可以去 [Prettier Playground](https://link.juejin.cn?target=https%3A%2F%2Fprettier.io%2Fplayground%2F) 大概把玩一会儿，下面我简单介绍下上述的配置：

- `trailingComma` ：对象的最后一个属性末尾也会添加 `,` ，比如 `{ a: 1, b: 2 }` 会格式为 `{ a: 1, b: 2, }` 。
- `tabWidth` ：缩进大小。
- `semi` ：分号是否添加，我以前从C++转前端的，有一段时间非常不能忍受不加分号的行为，现在香的一匹。
- `singleQuote` ：是否单引号，绝壁选择单引号啊，不会真有人还用双引号吧？不会吧！😏
- `jsxSingleQuote` ：jsx 语法下是否单引号，同上。
- `endOfLine` ：与 `.editorconfig` 保持一致设置。
- `printWidth` ：单行代码最长字符长度，超过之后会自动格式化换行。
- `bracketSpacing` ：在对象中的括号之间打印空格， `{a: 5}` 格式化为 `{ a: 5 }` 。
- `arrowParens` ：箭头函数的参数无论有几个，都要括号包裹。比如 `(a) => {}` ，如果设为 `avoid` ，会自动格式化为 `a => {}` 。

那我们现在也配置好了，但是咋用的呢？

- 一个是我们可以通过命令的形式去格式化某个文件下的代码，但是我们基本不会去使用，最终都是通过 `ESlint` 去检测代码是否符合规范。
- 二是当我们编辑完代码之后，按下 `ctrl+s` 保存就给我们自动把当前文件代码格式化了，既能实时查看格式化后的代码风格，又省去了命令执行代码格式化的多余工作。

你所需要做的是先安装扩展 [Prettier - Code formatter](https://link.juejin.cn?target=https%3A%2F%2Fmarketplace.visualstudio.com%2Fitems%3FitemName%3Desbenp.prettier-vscode) ：

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6410957ae01f44daa37bc9b3024932dd~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

当安装结束后， 在项目根目录新建一个文件夹 `.vscode` ，在此文件下再建一个 `settings.json` 文件：

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f35d7fef8e3c41d1b784597dc34dcbcc~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

该文件的配置优先于 vscode 全局的 `settings.json` ，这样别人下载了你的项目进行开发，也不会因为全局 `setting.json` 的配置不同而导致 `Prettier` 或之后会说到的 `ESLint` 、 `StyleLint` 失效，接下来在该文件内输入以下代码：

```json
{ 
  // 指定哪些文件不参与搜索
  "search.exclude": {
    "**/node_modules": true,
    "dist": true,
    "yarn.lock": true
  },
  "editor.formatOnSave": true,
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[less]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[scss]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
复制代码
```

`"editor.formatOnSave"` 的作用是在我们保存时，会自动执行一次代码格式化，而我们该使用什么格式化器？接下来的代码便是设置默认的格式化器，看名字大家也能看得出来了吧！

在遇到 `.js` 、 `.jsx` 、`.ts` 、`.tsx` 、`.json` 、`.html` 、`.md` 、 `.css` 、 `.less` 、 `.scss` 为后缀的文件时，都会去使用 `Prettier` 去格式化代码，而格式化的规则就是我们配置的 `.prettierrc` 决定的！

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a8d4c64b52ee49999e92926a15bcd94b~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

`.editorconfig` 配置文件中某些配置项是会和 `Prettier` 重合的，例如 指定缩进大小 两者都可以配置。

那么两者有什么区别呢？

我们可以看到 `EditorConfig` 的配置项都是一些不涉及具体语法的，比如 缩进大小、文移除多余空格等。

而 `Prettier` 是一个格式化工具，要根据具体语法格式化，对于不同的语法用单引号还是双引号，加不加分号，哪里换行等，当然，肯定也有缩进大小。

即使缩进大小这些共同都有的设置，两者也是不冲突的，设置 `EditorConfig` 的 `indent_size` 为 `4` ， `Prettier` 的 `tabWidth` 为 `2` 。

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/708e0d5d4fcb43479c283836e458931c~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

可以看到，在我们新起一行时，根据 `.editorconfig` 中的配置，缩进大小为 `4` ，所以光标直接跳到了此处，但是保存时，因为我们默认的格式化工具已经在 `.vscode/settings.json` 中设置为了 `Prettier` ，所以这时候读取缩进大小为 `2` 的配置，并正确格式化了代码。

当然，我还是建议大家两个都配置文件重合的地方都保持一致比较好～

### 3. ESLint

在上面我们配置了 `EditorConfig` 和 `Prettier` 都是为了解决**代码风格问题**，而 `ESLint` 是主要为了解决**代码质量问题**，它能在我们编写代码时就检测出程序可能出现的隐性BUG，通过 `eslint --fix` 还能自动修复一些代码写法问题，比如你定义了 `var a = 3` ，自动修复后为 `const a = 3` 。还有许多类似的强制扭转代码最佳写法的规则，在无法自动修复时，会给出红线提示，强迫开发人员为其寻求更好的解决方案。

> prettier 代码风格统一支持的语言更多，而且差异化小，eslint 一大堆的配置能弄出一堆风格，prettier 能对 ts js html css json md做风格统一，这方面 eslint 比不过。     --来自“三元小迷妹”

我们先把它用起来，直观感受一下其带来的好处！

首先在项目中安装 `eslint` ：

```bash
 npm install eslint -D
复制代码
```

安装成功后，执行以下命令：

```bash
npx eslint --init
复制代码
```

上述命令的功能为初始化 `ESLint` 的配置文件，采取的是问答的形式，特别人性化。不过在我们介绍各个问答之前先来看看这句命令中 `npx` 是什么。

实际上，要达到以上命令的效果还有两种方式。

一是直接找到我们项目中安装的 `eslint` 的可执行文件，如下图：

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3d602bbd9072438cac23fdd0e93724ec~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

然后根据该路径来执行命令：

```bash
./node_modules/.bin/eslint --init
复制代码
```

二是先全局安装 `eslint` ，直接执行以下命令即可：

```bash
# 全局安装 eslint
npm install eslint -g

# eslint 配置文件初始化
eslint --init
复制代码
```

现在让我们来说下这两种方式的缺点：

- 针对第一种，其实本质上来说和我们所推荐的 `npx` 形式没有区别，缺点是该命令太过于繁琐。
- 针对第二种，我们需要先全局进行 `eslint` 的安装，这会占据我们电脑的硬盘空间，且会将安装文件放到挺隐蔽的地方，个人有心里洁癖，非常接受不了这种全局安装的方式，特别是越来越多全局包的时候。再有一个比较大的问题是，因为我们执行 `eslint --init` 是使用全局安装的版本去初始化的，这有可能会和你现在项目中的 `eslint` 版本不一致。这个问题我就出现了，记得很久以前装的全局 `eslint` ，版本好低。

那么 `npx` 的作用就是抹掉了上述两个缺点，其是 `npm v5.2.0` 引入的一条命令，它在上述命令执行时：

- 会先去本地 `node_modules` 中找 `eslint` 的执行文件，如果找到了，就直接执行，相当于上面所说的第一种方式；
- 如果没有找到，就去全局找，找到了，就相当于上述第二种方式；
- 如果都没有找到，就下载一个临时的 `eslint` ，用完之后就删除这个临时的包，对本机完全无污染。

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3fabe1dd5bb44844bdadc18ca734437f~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

已经执行 `npx eslint --init` 的小伙伴现在会依次遇到下面问题，请跟我慢慢看来：

- How would you like to use ESLint?

  果断选择第三条 `To check syntax, find problems, and enforce code style` ，检查语法、检测问题并强制代码风格。

- What type of modules does your project use?

  项目非配置代码都是采用的 ES6 模块系统导入导出，选择 `JavaScript modules (import/export)` 。

- Which framework does your project use?

  显而易见，选择 `React` 。

- Does your project use TypeScript?

  果断用上 `Typescript` 啊，还记得我们文章的标题吗？选择 `Yes` 后生成的 `eslint` 配置文件会给我们默认配上支持 `Typescript` 的 `parse` 以及插件 `plugins` 等。

- Where does your code run?

`Browser` 和 `Node` 环境都选上，之后可能会编写一些 `node` 代码。

- How would you like to define a style for your project?

  选择 `Use a popular style guide` ，即使用社区已经制定好的代码风格，我们去遵守就行。

- Which style guide do you want to follow?

  选择 `Airbnb` 风格，都是社区总结出来的最佳实践。

- What format do you want your config file to be in?

  选择 `JavaScript` ，即生成的配置文件是 js 文件，配置更加灵活。

- Would you like to install them now with npm?

  当然 `Yes` 了～

在漫长的安装结束后，项目根目录下多出了新的文件 `.eslintrc.js` ，这便是我们的 `eslint` 配置文件了。其默认内容如下：

```javascript
module.exports = {
  env: {
    browser: true,
    es2020: true,
    node: true,
  },
  extends: ['plugin:react/recommended', 'airbnb'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 11,
    sourceType: 'module',
  },
  plugins: ['react', '@typescript-eslint'],
  rules: {},
}
复制代码
```

各个属性字段的作用可在 [Configuring ESLint](https://link.juejin.cn?target=https%3A%2F%2Feslint.bootcss.com%2Fdocs%2Fuser-guide%2Fconfiguring) 仔细了解，可能会比较迷惑的地方是 `extends` 和 `plugins` 的关系，其实 `plugins` 就是**插件**的意思，都是需要 npm 包的安装才可以使用，只不过默认支持简写，官网都有说；至于 `extneds` 其实就是使用我们已经下载的插件的某些预设规则。

现在我们对该配置文件作以下修改：

- 根据 [eslint-config-airbnb](https://link.juejin.cn?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Feslint-config-airbnb) 官方说明，如果要开启 React Hooks 的检查，需要在 extends 中添加一项 `'airbnb/hooks'` 。
- 根据 [@typescript-eslint/eslint-plugin](https://link.juejin.cn?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2F%40typescript-eslint%2Feslint-plugin) 官方说明，在 extends 中添加 `'plugin:@typescript-eslint/recommended'` 可开启针对 ts 语法推荐的规则定义。
- 需要添加一条很重要的 `rule` ，不然在 `.ts` 和 `.tsx` 文件中引入另一个文件模块会报错，比如：

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5eb20dd9985746d1a914ee152d626cf8~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

添加以下规则到 `rules` 即可：

```javascript
rules: {
  'import/extensions': [
    ERROR,
    'ignorePackages',
    {
      ts: 'never',
      tsx: 'never',
      json: 'never',
      js: 'never',
    },
  ],
}
复制代码
```

在之后我们安装 `typescript` 之后，会出现以下的怪异错误：

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d89fd182f34a48c798ac9b1c7366baee~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

大家先添加以下配置，毕竟之后一定要安装 `typscript` 的，把最常用的扩展名排在最前面，这里寻找文件时最快能找到：

```javascript
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.tsx', '.ts', '.js', '.json'],
      },
    },
  },
复制代码
```

接下来安装 2 个社区中比较火的 `eslint` 插件：

- `eslint-plugin-promise` ：让你把 Promise 语法写成最佳实践。
- `eslint-plugin-unicorn` ：提供了更多有用的配置项，比如我会用来规范关于文件命名的方式。

执行以下命令进行安装：

```bash
npm install eslint-plugin-promise eslint-plugin-unicorn -D
复制代码
```

在添加了部分规则 `rules` 后，我的配置文件修改之后如下：

```javascript
const OFF = 0
const WARN = 1
const ERROR = 2

module.exports = {
  env: {
    browser: true,
    es2020: true,
    node: true,
  },
  extends: [
    'airbnb',
    'airbnb/hooks',
    'plugin:react/recommended',
    'plugin:unicorn/recommended',
    'plugin:promise/recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 11,
    sourceType: 'module',
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.tsx', '.ts', '.js', '.json'],
      },
    },
  },
  plugins: ['react', 'unicorn', 'promise', '@typescript-eslint'],
  rules: {
    // 具体添加的其他规则大家可查看我的 github 查看
    // https://github.com/vortesnail/react-ts-quick-starter/blob/master/.eslintrc.js
  },
}

复制代码
```

> 在之后的配置过程中，我们可能还会需要对该文件进行更改😛，比如添加解决 eslint 和 prettier 的规则冲突处理插件，请大家期待一下下。

大家新建一个 `hello.ts` 文件，在里面打上以下代码：

```typescript
var add = (a, b) => {
  console.log(a + b)
  return a + b
}

export default add
复制代码
```

你会发现没有任何的错误提示，很明显上面的代码违反了不能使用 `var` 定义变量的规则，理论上来说一定会报一堆红线的～

这时候按下图看我们的 `ESLint` 输出：

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5b76234f94cd4a7ea4316d0ffa4d165b~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

原来是 `@typescript-eslint/eslint-plugin` 这个插件需要安装 `typescript` ，虽然我们这部分内容应该在之后再讲的，但是现在为了让大家写点代码测试看下 `eslint` 是否好用，我们就先安装一下吧：

```bash
npm install typescript -D
复制代码
```

安装完之后，你再回头看看刚才那个 `hello.ts` 文件内的代码，是不是一堆爆红了！
 ![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1a4a6ec14af2497da08abb39a657c179~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

我们知道 `eslint` 由编辑器支持是有自动修复功能的，首先我们需要安装扩展：

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4914dfb9800d4d7d8274cd8bfdf3b5ce~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

再到之前创建的 `.vscode/settings.json` 中添加以下代码：

```json
{
  "eslint.validate": ["javascript", "javascriptreact", "typescript", "typescriptreact"],
  "typescript.tsdk": "./node_modules/typescript/lib", // 代替 vscode 的 ts 语法智能提示
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
  },
}
复制代码
```

这时候我们保存时，就会开启 `eslint` 的自动修复，完美！

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3f587f8c3d9a47a68045afa04d2a0fbf~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

不过有时候我们并不希望 `ESLint` 或 `Prettier` 去对某些文件做任何修改，比如某个特定的情况下我想去看看打包之后的文件内容，里面的内容一定是非常不符合各种 lint 规则的，但我不希望按保存时对其进行格式化，此时就需要我们添加 `.eslintignore` 和 `.prettierignore` ，我一般会使这两个文件的内容都保持一致：

```bash
/node_modules
/build
/dist
复制代码
```

先添加以上三个需要忽略的文件目录好了，之后大家视情况而添加就行。

### 4. StyleLint

经过上面的一顿操作，我们的 js 或 ts 代码已经能有良好的代码风格了，但可别忘了还有样式代码的风格也需要统一啊！这个真的很有必要啊，有时候去调试其他人的样式代码，这里一坨那里一坨，看着属实难受。

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4e06103feb804d9fbea44f1bd19471d5~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

根据 [stylelint 官网介绍](https://link.juejin.cn?target=https%3A%2F%2Fstylelint.io%2Fuser-guide%2Fget-started)，我们先安装两个基本的包：

```bash
npm install stylelint stylelint-config-standard -D
复制代码
```

然后在项目根目录新建 `.stylelintrc.js` 文件，输入以下内容：

```javascript
module.exports = {
  extends: ['stylelint-config-standard'],
  rules: {
    'comment-empty-line-before': null,
    'declaration-empty-line-before': null,
    'function-name-case': 'lower',
    'no-descending-specificity': null,
    'no-invalid-double-slash-comments': null,
    'rule-empty-line-before': 'always',
  },
  ignoreFiles: ['node_modules/**/*', 'build/**/*'],
}
复制代码
```

同样，简单介绍下配置上的三个属性：

- `extends` ：其实和 `eslint` 的类似，都是扩展，使用 `stylelint` 已经预设好的一些规则。
- `rules` ：就是具体的规则，如果默认的你不满意，可以自己决定某个规则的具体形式。
- `ignoreFiles` ：不像 `eslint` 需要新建 ignore 文件， `stylelint` 配置就支持忽略配置字段，我们先添加 `node_modules` 和 `build` ，之后有需要大家可自行添加。

> 其中关于 `xxx/**/*` 这种写法的意思有不理解的，大家可在 `google` （或百度）**glob模式**。

与 `eslint` 一样，想要在编辑代码时有错误提示以及自动修复功能，我们需要 vscode 安装一个扩展：

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dd3bcba854724dce8b4e5f5802ab3d18~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

并且在 `.vscode/settings.json` 中增加以下代码：

```json
{
	// 使用 stylelint 自身的校验即可
  "css.validate": false,
  "less.validate": false,
  "scss.validate": false,
  
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.fixAll.stylelint": true
  },
}
复制代码
```

这时候随便建一个 `.less` 文件测试下，已经有错误提示和保存时自动修复功能了。

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/64ff438672fe4a2ebfe372459ea4f3e0~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

我们可以在社区下载一些优秀的 `stylelint extends` 和 `stylelint plugins` ：

- [stylelint-config-rational-order](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fconstverum%2Fstylelint-config-rational-order) 用于按照以下顺序将相关属性声明进行分组来对它们进行排序

```rust
1.Positioning   2.Box Model    3.Typography    4.Visual    5.Animation    6.Misc
复制代码
```

- [stylelint-declaration-block-no-ignored-properties](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fkristerkari%2Fstylelint-declaration-block-no-ignored-properties) 用于提示我们写的矛盾样式，比如下面的代码中 `width` 是会被浏览器忽略的，这可以避免我们犯一些低级错误～

```css
{ display: inline; width: 100px; }
复制代码
```

我们来一波安装：

```bash
npm install stylelint-order stylelint-config-rational-order stylelint-declaration-block-no-ignored-properties -D
复制代码
```

现在更改以下我们的配置文件：

```javascript
module.exports = {
  extends: ['stylelint-config-standard', 'stylelint-config-rational-order'],
  plugins: ['stylelint-order', 'stylelint-declaration-block-no-ignored-properties'],
  rules: {
    'plugin/declaration-block-no-ignored-properties': true,
    'comment-empty-line-before': null,
    'declaration-empty-line-before': null,
    'function-name-case': 'lower',
    'no-descending-specificity': null,
    'no-invalid-double-slash-comments': null,
    'rule-empty-line-before': 'always',
  },
  ignoreFiles: ['node_modules/**/*', 'build/**/*'],
}
复制代码
```

至此， `stylelint` 就配置完成了，具体的规则以及插件大家都可以在其官网进行浏览或查找，然后添加一些自己希望的规则定义。

### 5. lint命令

我们在 `package.json` 的 `scripts` 中增加以下三个配置：

```json
{
	scripts: {
  	"lint": "npm run lint-eslint && npm run lint-stylelint",
    "lint-eslint": "eslint -c .eslintrc.js --ext .ts,.tsx,.js src",
    "lint-stylelint": "stylelint --config .stylelintrc.js src/**/*.{less,css,scss}"
  }
}
复制代码
```

在控制台执行 `npm run lint-eslint` 时，会去对 `src/` 下的指定后缀文件进行 `eslint` 规则检测， `lint-stylelint` 也是同理， `npm run lint` 会两者都按顺序执行。

其实我个人来说，这几个命令我是都不想写进 `scripts` 中的，因为我们写代码的时候，不规范的地方就已经自动修复了，只要保持良好的习惯，看到有爆红线的时候想办法去解决它，而不是视而不见，那么根本不需要对所有包含的文件再进行一次命令式的规则校验。

但是对于新提交缓存区的代码还是有必要执行一次校验的，这个后面会说到。

### 6. ESLint、Stylelint 和 Prettier 的冲突

有时候 `eslint` 和 `stylelint` 的自定义规则和 `prettier` 定义的规则冲突了，比如在 `.eslintrc.js` 中某个 `extends` 的配置设置了缩进大小为 `4` ，但是我 `.prettierrc` 中我设置的缩进为 `2` ，那就会出现我们保存时，先是 `eslint` 的自动修复缩进大小为 `4` ，这个时候 `prettier` 不开心了，又强制把缩进改为了 `2` ，好了， `eslint` 不开心，代码直接爆红！

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d5a51013cfea462393f88b5c29e1088e~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

那么我们如何解决这部分冲突呢？

其实官方提供了很好的解决方案，查阅 [Integrating with Linters](https://link.juejin.cn?target=https%3A%2F%2Fprettier.io%2Fdocs%2Fen%2Fintegrating-with-linters.html) 可知，针对 `eslint` 和 `stylelint` 都有很好的插件支持，其原理都是禁用与 `prettier` 发生冲突的规则。

安装插件 [eslint-config-prettier](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fprettier%2Feslint-config-prettier) ，这个插件会禁用所有和 prettier 起冲突的规则：

```bash
npm install eslint-config-prettier -D
复制代码
```

添加以下配置到 `.eslintrc.js` 的 `extends` 中：

```json
{
  extends: [
    // other configs ...
   	'prettier',
    'prettier/@typescript-eslint',
    'prettier/react',
    'prettier/unicorn',
  ]
}
复制代码
```

这里需要注意， `'prettier'` 及之后的配置要放到原来添加的配置的后面，这样才能让 `prettier` 禁用之后与其冲突的规则。

`stylelint` 的冲突解决也是一样的，先安装插件 [stylelint-config-prettier](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fprettier%2Fstylelint-config-prettier) ：

```bash
npm install stylelint-config-prettier -D
复制代码
```

添加以下配置到 `.stylelintrc.js` 的 `extends` 中：

```json
{  
	extends: [
  	// other configs ...
    'stylelint-config-prettier'
  ]
}
复制代码
```

### 7. lint-staged

在项目开发过程中，每次提交前我们都要对代码进行格式化以及 `eslint` 和 `stylelint` 的规则校验，以此来强制规范我们的代码风格，以及防止隐性 BUG 的产生。

那么有什么办法只对我们 git 缓存区最新改动过的文件进行以上的格式化和 lint 规则校验呢？答案就是[ lint-staged](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fokonet%2Flint-staged) 。

我们还需要另一个工具 [husky](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Ftypicode%2Fhusky) ，它会提供一些钩子，比如执行 `git commit` 之前的钩子 `pre-commit` ，借助这个钩子我们就能执行 `lint-staged` 所提供的代码文件格式化及 lint 规则校验！

![图片名称](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/495fdb0146fc46a7b50745f67e6db50d~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

赶紧安装一下这两个插件吧：

```bash
npm install husky lint-staged -D
复制代码
```

随后在 `package.json` 中添加以下代码（位置随意，我比较习惯放在 `repository` 上面）：

```json
{
	"husky": {
    "hooks": {
      "pre-commit": "lint-staged",
    }
  },
  "lint-staged": {
    "*.{ts,tsx,js}": [
      "eslint --config .eslintrc.js"
    ],
    "*.{css,less,scss}": [
      "stylelint --config .stylelintrc.js"
    ],
    "*.{ts,tsx,js,json,html,yml,css,less,scss,md}": [
      "prettier --write"
    ]
  },
}
复制代码
```

首先，我们会对暂存区后缀为 `.ts .tsx .js` 的文件进行 `eslint` 校验， `--config` 的作用是指定配置文件。之后同理对暂存区后缀为 `.css .less .scss` 的文件进行 `stylelint` 校验，注意⚠️，我们没有添加 `--fix` 来自动修复不符合规则的代码，因为自动修复的内容对我们不透明，你不知道哪些代码被更改，这对我来说是无法接受的。

但是在使用 `prettier` 进行代码格式化时，完全可以添加 `--write` 来使我们的代码自动格式化，它不会更改语法层面上的东西，所以无需担心。

> 可能大家搜索一些文章的时候，会发现在 lint-staged 中还配置了一个 git add ，实际上在 v10 版本之后任何被修改了的原 staged 区的文件都会被自动 git add，所以无需再添加。

### 8. commitlint + changelog

> 在多人协作的项目中，如果 git 的提交说明精准，在后期协作以及 bug 处理时会变得有据可查，项目的开发可以根据规范的提交说明快速生成开发日志，从而方便开发者或用户追踪项目的开发信息和功能特性。

> 建议阅读 [Commit message 和 Change log 编写指南（阮一峰）](https://link.juejin.cn?target=http%3A%2F%2Fwww.ruanyifeng.com%2Fblog%2F2016%2F01%2Fcommit_message_change_log.html)

[commitlint](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fconventional-changelog%2Fcommitlint) 可以帮助我们进行 git commit 时的 message 格式是否符合规范，[conventional-changelog](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fconventional-changelog%2Fcommitlint) 可以帮助我们快速生成 `changelog` ，至于在命令行中进行可视化的 git commit 插件 [commitizen](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fcommitizen%2Fcz-cli) 我们就不配了，有兴趣的同学可以自行了解～

首先安装 `commitlint` 相关依赖：

```bash
npm install @commitlint/cli @commitlint/config-conventional -D
复制代码
```

[@commitlint/config-conventional](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fconventional-changelog%2Fcommitlint%2Ftree%2Fmaster%2F%40commitlint%2Fconfig-conventional) 类似 `eslint` 配置文件中的 `extends` ，它是官方推荐的 angular 风格的 commitlint 配置，提供了少量的 lint 规则，默认包括了以下除了我自己新增的 `type` 。

随后在根目录新建文件 `.commitlintrc.js` ，这就是我们的 commitlint 配置文件，写入以下代码：

```javascript
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      ['build', 'ci', 'chore', 'docs', 'feat', 'fix', 'perf', 'refactor', 'revert', 'style', 'test', 'anno'],
    ],
  },
}
复制代码
```

我自己增加了一种 `anno` ，目的是表示一些注释的增删改的提交。

```javascript
/**
 * build : 改变了build工具 如 webpack
 * ci : 持续集成新增
 * chore : 构建过程或辅助工具的变动
 * feat : 新功能
 * docs : 文档改变
 * fix : 修复bug
 * perf : 性能优化
 * refactor : 某个已有功能重构
 * revert : 撤销上一次的 commit
 * style : 代码格式改变
 * test : 增加测试
 * anno: 增加注释
 */
复制代码
```

随后回到 `package.json` 的 `husky` 配置，增加一个钩子：

```json
{
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged",
      "commit-msg": "commitlint --config .commitlintrc.js -E HUSKY_GIT_PARAMS"
    }
  },
}
复制代码
```

`-E HUSKY_GIT_PARAMS` 简单理解就是会拿到我们的 message ，然后 commitlint 再去进行 lint 校验。

接着配置生成我们的 changelog ，首先安装依赖：

```bash
npm install conventional-changelog-cli -D
复制代码
```

在 `package.json` 的 `scripts` 下增加一个命令：

```json
{
  "scripts": {
    "changelog": "conventional-changelog -p angular -i CHANGELOG.md -s"
  },
}
复制代码
```

之后就可以通过 `npm run changelog` 生成 angular 风格的 changelog ，需要注意的是，上面这条命令产生的 changelog 是基于上次 tag 版本之后的变更（feat、fix 等等）所产生的。

现在就来测试一下我们上面的工作有没有正常运行吧！执行以下提交信息不规范（chore 写成 chora）的命令：

```bash
# 提交所有变化到缓存区
git add -A
# 把暂存区的所有修改提交到分支 
git commit -m "chora: add commitlint to force commit style"
复制代码
```

像预期中的一致，出现了以下报错：

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e14dacc4d5604eb3aa719633d07dac63~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

那我们现在进行我们的提交，把故意写错的改回来：

```bash
git commit -m "chore: add commitlint to force commit style"
复制代码
```

这时候我们成功 commit ，再执行以下命令提交到远端：

```bash
git push origin master
复制代码
```

**经历了漫长的配置，我们“初步”形成了一个完善的项目开发环境，接下来就开始进入 Webpack 的世界吧！**

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6af99181ef924cafa07fb37104795f0e~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

## Webpack 基本配置

我们最终的配置要支持 `React` 和 `Typescript` 的开发与生产，现在的我们的思路是将对这两个部分的支持放到最后去配置，一开始先把必要的都配好，这样大家能有一个很直观的印象，什么时候该做什么？怎么做？

对于 `Webpack` 的配置，我会尽量地去解释清楚每一个新增的配置都有什么用，希望大家耐心阅读～

> ⚠️ 目前讲解的 webpack 版本为 4+

### 1. 开始

想要使用 webpack，这两个包你不得不装：

```bash
npm install webpack webpack-cli -D
复制代码
```

- `webpack` ：这不必多说，其用于编译 JavaScript 模块。
- `webpack-cli` ：此工具用于在命令行中运行 webpack。

紧接着我们在根目录下新建文件夹 `scripts` ，在之下再建一个文件夹 `config` ，在 `config` 中再建一个 `.js` 文件 `webpack.common.js` ，此结构如下：

```arduino
scripts/
    config/
    webpack.common.js
复制代码
```

为什么会是这样的目录结构，主要考虑到之后讲了 `webpack-merge` 之后，会把 webpack 的核心配置文件放到 `config` 下，其余的例如导出文件路径的文件模块放到 `config` 同级。总之大家先这样搞着，之后咱慢慢解释。

### 2. input、output

**入口(input)**和**出口(output)**是 webpack 的核心概念之二，从名字就能大概感知他们是干什么的：**指定一个（或多个）入口文件，经过一系列的操作之后转换成另一个（或多个）文件**。

接下来在 `webpack.common.js` 中输入以下代码：

```javascript
const path = require('path')

module.exports = {
  entry: {
    app: path.resolve(__dirname, '../../src/app.js'),
  },
  output: {
    filename: 'js/[name].[hash:8].js',
    path: path.resolve(__dirname, '../../dist'),
  },
}
复制代码
```

> webpack 配置是标准的 Node.js 的 CommonJS 模块，它通过 `require` 来引入其他模块，通过 `module.exports` 导出模块，由 webpack 根据对象定义的属性进行解析。

- `entry` ：定义了入口文件路径，其属性名 `app` 表示引入文件的名字。
- `output` ：定义了编译打包之后的文件名以及所在路径。

这段代码的意思就是告诉 webpack，入口文件是根目录下的 `src` 下的 `app.js` 文件，打包输出的文件位置为根目录下的 `dist` 中，注意到 `filename` 为 `js/[name].[hash:8].js` ，那么就会在 `dist` 目录下再建一个 `js` 文件夹，其中放了命名与入口文件命名一致，并带有 hash 值的打包之后的 js 文件。

接下来在根目录创建 `src` 文件夹，新建 `app.js` 文件，输入以下代码：

```javascript
const root = document.querySelector('#root')
root.innerHTML = 'hello, webpack!'
复制代码
```

现在我们尝试使用刚才的 webpack 配置对其进行打包，那如何操作呢？ 打开 `package.json` ，为其添加一条 npm 命令：

```diff
{
  "scripts": {
+   "build": "webpack --config ./scripts/config/webpack.common.js",
    "changelog": "conventional-changelog -p angular -i CHANGELOG.md -s",
    "lint": "npm run lint-eslint && npm run lint-stylelint",
    "lint-eslint": "eslint -c .eslintrc.js --ext .ts,.tsx,.js src",
    "lint-stylelint": "stylelint --config .stylelintrc.js src/**/*.{less,css,scss}"
  },
}
复制代码
```

> `--config` 选项来指定配置文件

然后在控制台输入：

```bash
npm run build
复制代码
```

等待一两秒后，你会发现根目录下真的多出了一个 `dist` 文件夹，里面的内容和我们 webpack 配置所想要达到的效果是一样的：一个 js 文件夹以及下面的（比如） `app.e406fb9b.js` 的文件。

至此，我们已经初步使用 webpack 打了一个包，接下来我们逐步开始扩展其他的配置以及相应优化吧！～

### 3. 公用变量文件

在上面简单的 webpack 配置中，我们发现有两个表示路径的语句：

```json
path.resolve(__dirname, '../../src/app.js')
path.resolve(__dirname, '../../dist')
复制代码
```

- `path.resolve` ：node 的官方 api，可以将路径或者路径片段解析成绝对路径。
- `__dirname` ：其总是指向被执行 js 文件的绝对路径，比如在我们 webpack 文件中访问了 `__dirname` ，那么它的值就是在电脑系统上的绝对路径，比如在我电脑上就是：

```arduino
/Users/RMBP/Desktop/react-ts-quick-starter/scripts/config
复制代码
```

所以我们上面的写法，大家可以简单理解为， `path.resolve` 把**根据当前文件的执行路径下**而找到的想要访问到的**文件相对路径**转换成了：**该文件在系统中的绝对路径！**

比如我的就是：

```bash
/Users/RMBP/Desktop/react-ts-quick-starter/src/app.js
复制代码
```

但是大家也看出来了，这种写法需要不断的 `../../` ，这个在文件层级较深时，很容易出错且很不优雅。那我们就换个思路，都从根目录开始找所需的文件路径不久很简单了吗，相当于省略了 `../../` 这一步。

在 `scripts` 下新建一个 `constant.js` 文件，专门用于存放我们的公用变量（之后还会有其他的）：

```diff
scripts/
	config/
  	webpack.common.js
+ constant.js
复制代码
```

在里面定义我们的变量：

```javascript
const path = require('path')

const PROJECT_PATH = path.resolve(__dirname, '../')
const PROJECT_NAME = path.parse(PROJECT_PATH).name

module.exports = { 
  PROJECT_PATH,
  PROJECT_NAME
}
复制代码
```

- `PROJECT_PATH` ：表示项目的根目录。
- `PROJECT_NAME` ：表示项目名，目前不用，但之后的配置会用到，我们就先定义好吧～

> 上面两个简单的 node api 大家可以自己简单了解一下，不想了解也可以，只要明白其有啥作用就行。

然后在 `webpack.common.js` 中引入，修改代码：

```javascript
const { resolve } = require('path')
const { PROJECT_PATH } = require('../constants')

module.exports = {
  entry: {
    app: resolve(PROJECT_PATH, './src/app.js'),
  },
  output: {
    filename: 'js/[name].[hash:8].js',
    path: resolve(PROJECT_PATH, './dist'),
  },
}
复制代码
```

好了，现在是不是看起来清爽多了，大家可以 `npm run build` 验证下自己代码是不是有写错或遗漏啥的～🐶

### 4. 区分开发/生产环境

在 webpack 中针对开发环境与生产环境我们要分别配置，以适应不同的环境需求，比如在开发环境中，报错要能定位到源代码的具体位置，而这又需要打出额外的 `.map` 文件，所以在生产环境中为了不牺牲页面性能，不需要添加此功能，毕竟，没人会在生产上调试代码吧？

虽然都要分别配置，但是又有挺多基础配置是开发和生产都需要且相同的，那我们不可能写两份文件，写两次基础配置吧？这也太冗余了，不过不用担心，[webpack-merge](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fsurvivejs%2Fwebpack-merge) 为我们都想好了。

安装它：

```bash
npm install webpack-merge -D
复制代码
```

在 `scripts/config` 下新建文件 `webpack.dev.js` 作为开发环境配置，并输入以下代码：

```javascript
const { merge } = require('webpack-merge')
const common = require('./webpack.common.js')

module.exports = merge(common, {
  mode: 'development',
})
复制代码
```

同样地，在 `scripts/config` 下新建文件 `webpack.prod.js` 作为生产环境配置，并输入以下代码：

```javascript
const { merge } = require('webpack-merge')
const common = require('./webpack.common.js')

module.exports = merge(common, {
  mode: 'production',
})
复制代码
```

> 在我使用 `require('webpack-merge')` 时，给我报了以下 eslint 的报错： 'webpack-merge' should be listed in the project's dependencies, not devDependencies. 只需要在 `.eslintrc.js` 中添加以下规则即可解决： `'import/no-extraneous-dependencies': [ERROR, { devDependencies: true }]` 

虽然都分开了配置，但是在公共配置中，还是可能会出现某个配置的某个选项在开发环境和生产环境中采用不同的配置，这个时候我们有两种选择：

- 一是分别在 dev 和 prod 配置文件中写一遍，common 中就不写了。
- 二是设置某个环境变量，根据这个环境变量来判别不同环境。

显而易见，为了使代码最大的优雅，采用第二种。

[cross-env](https://link.juejin.cn?target=https%3A%2F%2Fwww.npmjs.com%2Fpackage%2Fcross-env) 可跨平台设置和使用环境变量，不同操作系统设置环境变量的方式不一定相同，比如 Mac 电脑上使用 `export NODE_ENV=development` ，而 Windows 电脑上使用的是 `set NODE_ENV=development` ，有了这个利器，我们无需在考虑操作系统带来的差异性。

安装它：

```bash
npm install cross-env -D
复制代码
```

然后在 `package.json` 中添加修改以下代码：

```diff
{
  "scripts": {
+   "start": "cross-env NODE_ENV=development webpack --config ./scripts/config/webpack.dev.js",
+   "build": "cross-env NODE_ENV=production webpack --config ./scripts/config/webpack.prod.js",
-   "build": "webpack --config ./scripts/config/webpack.common.js",
  },
}
复制代码
```

修改 `srcipt/constants.js` 文件，增加一个公用布尔变量 `isDev` ：

```javascript
const isDev = process.env.NODE_ENV !== 'production'

module.exports = {
  isDev,
	// other
}
复制代码
```

我们现在就使用这个环境变量做点事吧！记得之前配的公共配置中，我们给出口文件的名字配了 `hash:8` ，原因是在生产环境中，即用户已经在访问我们的页面了，他第一次访问时，请求了比如 `app.js` 文件，根据浏览器的缓存策略会将这个文件缓存起来。然后我们开发代码完成了一版功能迭代，涉及到打包后的 `app.js` 发生了大变化，但是该用户继续访问我们的页面时，如果缓存时间没有超出或者没有人为清除缓存，那么他将继续得到的是已缓存的 `app.js` ，这就糟糕了。

于是，当我们文件加了 hash 后，根据入口文件内容的不同，这个 hash 值就会发生非常夸张的变化，当更新到线上，用户再次请求，因为缓存文件中找不到同名文件，就会向服务器拿最新的文件数据，这下就能保证用户使用到最新的功能。

不过，这个 hash 值在开发环境中并不需要，于是我们修改 `webpack.common.js` 文件：

```diff
- const { PROJECT_PATH } = require('../constants')
+ const { isDev, PROJECT_PATH } = require('../constants')

module.exports = {
	// other...
  output: {
-   filename: 'js/[name].[hash:8].js',
+   filename: `js/[name]${isDev ? '' : '.[hash:8]'}.js`,
    path: resolve(PROJECT_PATH, './dist'),
  },
}

复制代码
```

### 5. mode

在我们没有设置 `mode` 时，webpack 默认为我们设为了 `mode: 'prodution'` ，所以之前打包后的 js 文件代码都没法看，因为在 `production` 模式下，webpack 默认会丑化、压缩代码，还有其他一些默认开启的配置。

我们只要知道，不同模式下 webpack 为为其默认开启不同的配置，有不同的优化，详细可见 [webpack.mode](https://link.juejin.cn?target=https%3A%2F%2Fwebpack.js.org%2Fconfiguration%2Fmode%2F%23root)。

然后接下来大家可以分别执行以下命令，看看分别打的包有啥区别，主要感知下我们上面所说的：

```bash
# 开发环境打包
npm run start

# 生产环境打包
npm run build
复制代码
```

### 6. 本地服务实时查看页面

说了这么多，我们到现在甚至连个页面都看不到，使用过各种脚手架的朋友一定很熟悉 `npm run start` ，它直接起一个本地服务，然后页面就出来了。而我们现在执行这个命令却只能简单的打个包，别急，我们借助 [webpack-dev-server](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fwebpack%2Fwebpack-dev-server) 和 [html-webpack-plugin](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fjantimon%2Fhtml-webpack-plugin) 就能实现，现在先把它们安装下来：

```bash
npm install webpack-dev-server html-webpack-plugin -D
复制代码
```

简单介绍一下两个工具的作用：

- `html-webpack-plugin` ：每一个页面是一定要有 `html` 文件的，而这个插件能帮助我们将打包后的 js 文件自动引进 `html` 文件中，毕竟你不可能每次更改代码后都手动去引入 js 文件。
- `webpack-dev-server` ：可以在本地起一个 http 服务，通过简单的配置还可指定其端口、热更新的开启等。

现在，我们先在项目根目录下新建一个 `public` 文件夹，里面存放一些公用的静态资源，现在我们先在其中新建一个 `index.html` ，写入以下内容：

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>React+Typescript 快速开发脚手架</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>
复制代码
```

> 注意⚠️：里面有一个 div 标签，id 值为 root

因为 `html-webpack-plugin` 在开发和生产环境我们都需要配置，于是我们打开 `webpck.common.js` 增加以下内容：

```javascript
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  entry: {...},
  output: {...},
  plugins: [
  	new HtmlWebpackPlugin({
      template: resolve(PROJECT_PATH, './public/index.html'),
      filename: 'index.html',
      cache: fale, // 特别重要：防止之后使用v6版本 copy-webpack-plugin 时代码修改一刷新页面为空问题。
      minify: isDev ? false : {
        removeAttributeQuotes: true,
        collapseWhitespace: true,
        removeComments: true,
        collapseBooleanAttributes: true,
        collapseInlineTagWhitespace: true,
        removeRedundantAttributes: true,
        removeScriptTypeAttributes: true,
        removeStyleLinkTypeAttributes: true,
        minifyCSS: true,
        minifyJS: true,
        minifyURLs: true,
        useShortDoctype: true,
      },
    }),
  ]
}

复制代码
```

可以看到，我们以 `public/index.html` 文件为模板，并且在生产环境中对生成的 `html` 文件进行了代码压缩，比如去除注释、去除空格等。

> plugin 是 webpack 的核心功能，它丰富了 webpack 本身，针对是 loader 结束后，webpack打包的整个过程，它并不直接操作文件，而是基于事件机制工作，会监听 webpack 打包过程中的某些节点，执行广泛的任务。

随后在 `webpack.dev.js` 下增加本地服务的配置：

```javascript
const { SERVER_HOST, SERVER_PORT } = require('../constants')

module.exports = merge(common, {
  mode: 'development',
  devServer: {
    host: SERVER_HOST, // 指定 host，不设置的话默认是 localhost
    port: SERVER_PORT, // 指定端口，默认是8080
    stats: 'errors-only', // 终端仅打印 error
    clientLogLevel: 'silent', // 日志等级
    compress: true, // 是否启用 gzip 压缩
    open: true, // 打开默认浏览器
    hot: true, // 热更新
  },
})
复制代码
```

我们定义了两个新的变量 `SERVER_HOST` 和 `SERVER_PORT` ，在 `constants.js` 中定义它们：

```javascript
const SERVER_HOST = '127.0.0.1'
const SERVER_PORT = 9000

module.exports = {
  SERVER_HOST,
  SERVER_PORT,
	// ...
}

复制代码
```

其中提高开发幸福度的配置项：

- `stats` ：当设为 `error-only` 时，终端中只会打印错误日志，这个配置个人觉得很有用，现在开发中经常会被一堆的 warn 日志占满，比如一些 eslint 的提醒规则，编译信息等，头疼的很。
- `clientLogLevel` ：设为 `slient` 之后，原来的三条信息会变为只有一条。

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a13443e0abcf4c688e6ac57b456a5bf9~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

- `hot` ：这个配置开启后，之后在配合其他配置，可以开启热更新，我们之后再说。

现在配置好了本地服务的相关配置，我们还需要回到 `package.json` 中修改 `start` 命令：

```diff
{
  "scripts": {
+   "start": "cross-env NODE_ENV=development webpack-dev-server --config ./scripts/config/webpack.dev.js",
-   "start": "cross-env NODE_ENV=development webpack --config ./scripts/config/webpack.dev.js",
  },
}
复制代码
```

然后确认一下， `src/app.js` 中的代码如下：

```javascript
const root = document.querySelector('#root')
root.innerHTML = 'hello, webpack!'
复制代码
```

很简单，就是往之前在 `html` 文件中定义的 id 为 root 的 div 标签下加了一个字符串。 现在，执行以下命令：

```bash
npm run start
复制代码
```

你会发现浏览器默认打开了一个页面，屏幕上出现了期待中的 `hello, webpack!` 。查看控制台，发现 `html` 文件真的就自动引入了我们打包后的文件～

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/04cc4119d2eb4391992e7c2fede1d545~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

至此，我们已经能利用本地服务实时进行页面更新了！当然，这远远是不够的，我们会一步一步继续，尽可能的去完善。

### 7. devtool

`devtool` 中的一些设置，可以帮助我们将编译后的代码映射回原始源代码，即大家经常听到的 `source-map` ，这对于调试代码错误的时候特别重要，而不同的设置会明显影响到构建和重新构建的速度。所以选择一个适合自己的很重要。

它都有哪些值可以设置，[官方 devtool 说明](https://link.juejin.cn?target=https%3A%2F%2Fwebpack.js.org%2Fconfiguration%2Fdevtool%2F)中说的很详细，我就不具体展开了，**在这里我非常非常无敌强烈建议大家故意写一些有错误的代码，然后使用每个设置都试试看！**在开发环境中，我个人比较能接受的是 `eval-source-map` ，所以我会在 `webpack.dev.js` 中添加以下代码：

```diff
module.exports = merge(common, {
  mode: 'development',
+ devtool: 'eval-source-map',
})
复制代码
```

在生产环境中我直接设为 `none` ，不需要 `source-map` 功能，在 `webpack.prod.js` 中添加以下代码：

```diff
module.exports = merge(common, {
  mode: 'production',
+ devtool: 'none',
})
复制代码
```

通过上面配置，我们本地进行开发时，代码出现了错误，控制台的错误日志就会精确地告诉你错误的代码文件、位置等信息。比如我们在 `src/app.js` 中第 `5` 行故意写个错误代码：

```javascript
const root = document.querySelector('#root')
root.innerHTML = 'hello, webpack!'

const a = 5
a = 6
复制代码
```

其错误日志提示我们：你的 `app.js` 文件中第 `5` 行出错了，具体错误原因为 `balabala....` ，赶紧看看吧～

![img](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/748a6bc1ac074073a8e85d9c8f8c0ce4~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

完美！完美了吗？

![img](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6f7a5340c78c404cafd44eba1312231e~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

如果你已经执行过多次 `npm run build` ，你会发现事情不简单：

![img](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e03eadb520384332a1d1b25be05b1f66~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

妈蛋，多出了那么多 `app.xxxxxxxx.js` ，为了我们最终打包后没有前一次打包出来的多余文件，得想个办法处理这个问题。

### 8. 打包编译前清理 dist 目录

我们发现每次打出来的文件都会继续残留在 dist 目录中，当然如果你足够勤快，可以每次打包前手动清理一下，但是这种勤劳是毫无意义的。

借助 [clean-webpack-plugin](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fjohnagan%2Fclean-webpack-plugin) 可以实现每次打包前先处理掉之前的 dist 目录，以保证每次打出的都是当前最新的，我们先安装它：

```bash
npm install clean-webpack-plugin -D
复制代码
```

打开 `webpack.prod.js` 文件，增加以下代码：

```javascript
const { CleanWebpackPlugin } = require('clean-webpack-plugin')

module.exports = {
	// other...
  plugins: [
    new CleanWebpackPlugin(),
  ],
}
复制代码
```

它不需要你去指定要删除的目录的位置，会自动找到 `output` 中的 `path` 然后进行清除。 现在再执行一下 `npm run build` ，看看打出来的 dist 目录是不是干净清爽了许多？

### 9. 样式文件处理

如果你现在在 `src/` 目录下新建一个 `app.css` 文件，给 `#root` 随便添加一个样式， `app.js` 中通过 `import './app.css'` ，再进行打包或本地服务启动，webpack 直接就会报错，因为 webpack 只会编译 `.js` 文件，它是不支持直接处理 `.css` 、 `.less` 或 `.scss` 文件的，我们需要借助 webpack 中另一个很核心的东西：**loader **。

> loader 用于对模块的源代码进行转换。loader 可以使你在 `import` 或"加载"模块时预处理文件。因此，loader 类似于其他构建工具中“任务(task)”，并提供了处理前端构建步骤的强大方法。loader 可以将文件从不同的语言（如 TypeScript）转换为 JavaScript，或将内联图像转换为 data URL。loader 甚至允许你直接在 JavaScript 模块中 `import` CSS文件！

#### CSS 样式文件处理

处理 `.css` 文件我们需要安装 [style-loader](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fwebpack-contrib%2Fstyle-loader) 和 [css-loader](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fwebpack-contrib%2Fcss-loader) ：

```bash
npm install style-loader css-loader -D
复制代码
```

- 遇到后缀为 `.css` 的文件，webpack 先用 `css-loader` 加载器去解析这个文件，遇到 `@import` 等语句就将相应样式文件引入（所以如果没有 `css-loader` ，就没法解析这类语句），计算后生成**css字符串**，接下来 `style-loader` 处理此字符串生成一个内容为最终解析完的 css 代码的 style 标签，放到 head 标签里。
- `loader` 是有顺序的，webpack 肯定是先将所有 css 模块依赖解析完得到计算结果再创建 style 标签。因此应该把 `style-loader` 放在 `css-loader` 的前面（**webpack loader 的执行顺序是从右到左，即从后往前**）。

于是，打开我们的 `webpack.common.js` ，写入以下代码：

```javascript
module.exports = {
	// other...
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              modules: false, // 默认就是 false, 若要开启，可在官网具体查看可配置项
              sourceMap: isDev, // 开启后与 devtool 设置一致, 开发环境开启，生产环境关闭
              importLoaders: 0, // 指定在 CSS loader 处理前使用的 laoder 数量
            },
          },
        ],
      },
    ]
  },
}
复制代码
```

`test` 字段是匹配规则，针对符合规则的文件进行处理。

`use` 字段有几种写法：

- 可以是一个字符串，假如我们只使用 `style-loader` ，只需要 `use: 'style-loader'` 。
- 可以是一个数组，假如我们不对 `css-loader` 做额外配置，只需要 `use: ['style-loader', 'css-loader']` 。
- 数组的每一项既可以是字符串也可以是一个对象，当我们需要在`webpack` 的配置文件中对 `loader` 进行配置，就需要将其编写为一个对象，并且在此对象的 `options` 字段中进行配置。比如我们上面要对 `css-loader` 做配置的写法。

#### LESS 样式文件处理

处理 `.less` 文件我们需要安装 [less](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fless%2Fless.js) 和 [less-loader](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fwebpack-contrib%2Fless-loader) ：

```bash
npm install less less-loader -D
复制代码
```

- 遇到后缀为 `.less` 文件， `less-loader` 会将你写的 less 语法转换为 css 语法，并转为 `.css` 文件。
- `less-loader` 依赖于 `less` ，所以必须都安装。

继续在 `webpack.common.js` 中写入代码：

```javascript
module.exports = {
	// other...
  module: {
    rules: [
      { /* ... */ },
      {
        test: /\.less$/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              modules: false,
              sourceMap: isDev,
              importLoaders: 1, // 需要先被 less-loader 处理，所以这里设置为 1
            },
          },
          {
            loader: 'less-loader',
            options: {
              sourceMap: isDev,
            },
          },
        ],
      },
    ]
  },
}
复制代码
```

#### SASS 样式文件处理

处理 `.scss` 文件我们需要安装 [node-sass](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fsass%2Fnode-sass) 和 [sass-loader](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fwebpack-contrib%2Fsass-loader) ：

```bash
npm install node-sass sass-loader -D
复制代码
```

- 遇到 `.scss` 后缀的文件， `sass-loader` 会将你写的 sass 语法转为 css 语法，并转为 `.css` 文件。
- 同样地， `sass-loader` 依赖于 `node-sass` ，所以两个都需要安装。（ `node-sass` 我不用代理就没有正常安装上过，还好我们一开始就在配置文件里设了淘宝镜像源）

继续在 `webpack.common.js` 中写入代码：

```javascript
module.exports = {
	// other...
  module: {
    rules: [
      { /* ... */ },
      {
        test: /\.scss$/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              modules: false,
              sourceMap: isDev,
              importLoaders: 1, // 需要先被 sass-loader 处理，所以这里设置为 1
            },
          },
          {
            loader: 'sass-loader',
            options: {
              sourceMap: isDev,
            },
          },
        ],
      },
    ]
  },
}
复制代码
```

现在，通过以上配置之后，你再把 `src/app.css` 改为 `app.less` 或 `app.scss` ，执行 `npm run start` ，你会发现咱们的样式正常加载了出来，开心噢～

#### PostCSS 处理浏览器兼容问题

postcss 一种对 css 编译的工具，类似 babel 对 js 一样通过各种插件对 css 进行处理，在这里我们主要使用以下插件：

- [postcss-flexbugs-fixes](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fluisrudge%2Fpostcss-flexbugs-fixes) ：用于修复一些和 flex 布局相关的 bug。
- [postcss-preset-env](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fcsstools%2Fpostcss-preset-env) ：将最新的 CSS 语法转换为目标环境的浏览器能够理解的 CSS 语法，目的是使开发者不用考虑浏览器兼容问题。我们使用 [autoprefixer](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fpostcss%2Fautoprefixer) 来自动添加浏览器头。
- [postcss-normalize](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fcsstools%2Fpostcss-normalize) ：从 browserslist 中自动导入所需要的 normalize.css 内容。

安装上面提到的所需的包：

```bash
npm install postcss-loader postcss-flexbugs-fixes postcss-preset-env autoprefixer postcss-normalize -D
复制代码
```

将 `postcss-loader` 放到 `css-loader` 后面，配置如下：

```javascript
{
  loader: 'postcss-loader',
  options: {
    ident: 'postcss',
    plugins: [
      require('postcss-flexbugs-fixes'),
      require('postcss-preset-env')({
        autoprefixer: {
          grid: true,
          flexbox: 'no-2009'
        },
        stage: 3,
      }),
      require('postcss-normalize'),
    ],
    sourceMap: isDev,
  },
},
复制代码
```

但是我们要为每一个之前配置的样式 loader 中都要加一段这个，这代码会显得非常冗余，于是我们把公共逻辑抽离成一个函数，与 `cra` 一致，命名为 `getCssLoaders` ，因为新增了 `postcss-loader` ，所以我们要修改 `importLoaders` ，于是我们现在的 `webpack.common.js` 修改为以下这样：

```javascript
const getCssLoaders = (importLoaders) => [
  'style-loader',
  {
    loader: 'css-loader',
    options: {
      modules: false,
      sourceMap: isDev,
      importLoaders,
    },
  },
  {
    loader: 'postcss-loader',
    options: {
      ident: 'postcss',
      plugins: [
        // 修复一些和 flex 布局相关的 bug
        require('postcss-flexbugs-fixes'),
        require('postcss-preset-env')({
          autoprefixer: {
            grid: true,
            flexbox: 'no-2009'
          },
          stage: 3,
        }),
        require('postcss-normalize'),
      ],
      sourceMap: isDev,
    },
  },
]

module.exports = {
	// other...
  module: {
    rules: [
      {
        test: /\.css$/,
        use: getCssLoaders(1),
      },
      {
        test: /\.less$/,
        use: [
          ...getCssLoaders(2),
          {
            loader: 'less-loader',
            options: {
              sourceMap: isDev,
            },
          },
        ],
      },
      {
        test: /\.scss$/,
        use: [
          ...getCssLoaders(2),
          {
            loader: 'sass-loader',
            options: {
              sourceMap: isDev,
            },
          },
        ],
      },
    ]
  },
  plugins: [//...],
}

复制代码
```

最后，我们还得在 `package.json` 中添加 `browserslist` （指定了项目的目标浏览器的范围）：

```json
{
  "browserslist": [
    ">0.2%",
    "not dead", 
    "ie >= 9",
    "not op_mini all"
  ],
}
复制代码
```

现在，在如果你在入口文件（比如我之前一直用的 `app.js` ）随便引一个写了 `display: flex` 语法的样式文件， `npm run start` 看看是不是自动加了浏览器前缀了呢？快试试吧！

### 10. 图片和字体文件处理

我们可以使用 [file-loader](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fwebpack-contrib%2Ffile-loader) 或者 [url-loader](https://link.juejin.cn?target=https%3A%2F%2Fgithub.com%2Fwebpack-contrib%2Furl-loader) 来处理本地资源文件，比如图片、字体文件，而 `url-loader` 具有 `file-loader` 所有的功能，还能在图片大小限制范围内打包成 base64 图片插入到 js 文件中，这样做的好处是什么呢？别急，我们先安装所需要的包（后者依赖前者，所以都要安装）：

```bash
npm install file-loader url-loader -D
复制代码
```

然后在 `webpack.common.js` 中继续在 `modules.rules` 中添加以下代码：

```javascript
module.exports = {
  // other...
  module: {
    rules: [
      // other...
      {
        test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/],
        use: [
          {
            loader: 'url-loader',
            options: {
              limit: 10 * 1024,
              name: '[name].[contenthash:8].[ext]',
              outputPath: 'assets/images',
            },
          },
        ],
      },
      {
        test: /\.(ttf|woff|woff2|eot|otf)$/,
        use: [
          {
            loader: 'url-loader',
            options: {
              name: '[name].[contenthash:8].[ext]',
              outputPath: 'assets/fonts',
            },
          },
        ],
      },
    ]
  },
  plugins: [//...],
}
复制代码
```

- `[name].[contenthash:8].[ext]` 表示输出的文件名为 `原来的文件名.哈希值.后缀` ，有了这个 hash 值，可防止图片更换后导致的缓存问题。
- `outputPath` 是输出到 `dist` 目录下的路径，即图片目录 `dist/assets/images` 以及字体相关目录 `dist/assets/fonts` 下。
- `limit` 表示如果你这个图片文件大于 `10240b` ，即 `10kb` ，那我 `url-loader` 就不用，转而去使用 `file-loader` ，把图片正常打包成一个单独的图片文件到设置的目录下，若是小于了 `10kb` ，就将图片打包成 base64 的图片格式插入到打包之后的文件中，这样做的好处是，减少了 http 请求，但是如果文件过大，js文件也会过大，得不偿失，这是为什么有 `limit` 的原因！

接下来大家引一下本地的图片并放到 img 标签中，或者去 [iconfont](https://link.juejin.cn?target=https%3A%2F%2Fwww.iconfont.cn%2F) 下个字体图标试试吧～

不幸的是，当你尝试引入一张图片的时候，会有以下 ts 的报错（如果你安装了 ts 的话）：

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dd40781cd0be46e8b2487dd9823719aa~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

这个时候在 `src/` 下新建以下文件 `typings/file.d.ts` ，输入以下内容即可：

```javascript
declare module '*.svg' {
  const path: string
  export default path
}

declare module '*.bmp' {
  const path: string
  export default path
}

declare module '*.gif' {
  const path: string
  export default path
}

declare module '*.jpg' {
  const path: string
  export default path
}

declare module '*.jpeg' {
  const path: string
  export default path
}

declare module '*.png' {
  const path: string
  export default path
}
复制代码
```

其实看到现在已经很不容易了，不过我相信大家仔细跟到现在的话，也会收获不少的，上面的 webpack 基本配置只是配置了最基本的功能，接下来我们要达到支持 React，TypeScript 以及一堆的开发环境和生产环境的优化，大家加油噢～

![img](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/90c09aca623f4ec2a5b1b624cf89fac7~tplv-k3u1fbpfcp-zoom-in-crop-mark:3024:0:0:0.awebp)

由于字数限制，我只能分篇了～

[我是这样搭建Typescript+React项目环境的（二）！（2.7w字详解）](https://juejin.cn/post/6860134655568871437)


作者：vortesnail
链接：https://juejin.cn/post/6860129883398668296
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。