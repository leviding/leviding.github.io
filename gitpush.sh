#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 提交 GitHub 后 CI 自动部署
git init
git add -A
git commit -m ':pencil: update content'
git push original source
