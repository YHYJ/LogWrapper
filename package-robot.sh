#!/usr/bin/env bash

: << !
Name: package-robot.sh
Author: YJ
Email: yj1516268@outlook.com
Created Time: 2023-02-08 16:46:28

Description: 构建并上传Python包，清除构建生成文件

Attentions:
-

Depends:
-
!

# 进入虚拟环境
readonly virtualenvwrapper="/usr/bin/virtualenvwrapper.sh"
readonly virtualenvwrapper_lazy="/usr/bin/virtualenvwrapper_lazy.sh"

if [ -s "$virtualenvwrapper_lazy" ]; then
  # shellcheck source=/dev/null
  source "$virtualenvwrapper_lazy"
else
  # shellcheck source=/dev/null
  source "$virtualenvwrapper"
fi
workon build-upload
echo -e "Now in 'build-upload' virtual environment"

# 安装依赖包
python3 -m pip install --upgrade build twine

# 构建 & 上传
python3 -m build
python3 -m twine upload --repository pypi dist/*

# 清除构建生成文件
rm -rf dist src/logwrapper.egg-info
