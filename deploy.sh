#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
hexo clean
hexo douban -b
hexo douban -m
hexo generate
hexo deploy

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

# git init
# git add -A
# git commit -m ':pencil: update content'
# git push original master
