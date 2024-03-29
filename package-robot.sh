#!/usr/bin/env bash

: << !
Name: package-robot.sh
Author: YJ
Email: yj1516268@outlook.com
Created Time: 2023-02-13 10:24:05

Description: Python包的构建-上传-清理

Attentions:
-

Depends:
-
!

####################################################################
#+++++++++++++++++++++++++ Define Variable ++++++++++++++++++++++++#
####################################################################
#------------------------- Program Variable
# program name
name=$(basename "$0")
readonly name
# program version
readonly major_version=0.0.2
readonly minor_version=20230214
readonly rel_version=1

#------------------------- Exit Code Variable
readonly err_unknown=255    # 未知错误

#------------------------- Parameter Variable
# description variable
readonly desc="用于Python包的构建-上传-清理"
# environment variable
readonly virtualenvwrapper="/usr/bin/virtualenvwrapper.sh"
readonly virtualenvwrapper_lazy="/usr/bin/virtualenvwrapper_lazy.sh"

####################################################################
#+++++++++++++++++++++++++ Define Function ++++++++++++++++++++++++#
####################################################################
#------------------------- Info Function
function helpInfo() {
  echo -e ""
  echo -e "\033[32m$name\033[0m\033[1m$desc\033[0m"
  echo -e "--------------------------------------------------"
  echo -e "Usage:"
  echo -e ""
  echo -e "     $name [OPTION]"
  echo -e ""
  echo -e "Options:"
  echo -e "     -a, --all         完整的构建-上传-清除流程"
  echo -e "     -b, --build       构建Python包"
  echo -e "     -u, --upload      上传构建的包"
  echo -e "     -c, --clean       清除构建文件"
  echo -e ""
  echo -e "     -h, --help        显示帮助信息"
  echo -e "     -v, --version     显示版本信息"
}

function versionInfo() {
  echo -e ""
  echo -e "\033[1m$name\033[0m version (\033[1m$major_version-$minor_version.$rel_version\033[0m)"
}
#------------------------- Feature Function
if [ -s "$virtualenvwrapper_lazy" ]; then
  # shellcheck source=/dev/null
  source "$virtualenvwrapper_lazy"
else
  # shellcheck source=/dev/null
  source "$virtualenvwrapper"
fi

function builder() {
  workon build-upload
  echo -e "Now in 'build-upload' virtual environment"

  # 安装依赖包
  python3 -m pip install --upgrade build

  # 构建
  python3 -m build

  echo -e "\nBuild complete"
}

function uploader() {
  workon build-upload
  echo -e "Now in 'build-upload' virtual environment"

  # 安装依赖包
  python3 -m pip install --upgrade twine

  # 上传
  python3 -m twine upload --repository pypi dist/*

  echo -e "\nUpload complete"
}

function cleaner() {
  # 清除构建生成文件
  rm -rf dist src/logwrapper.egg-info

  echo -e "\nClear complete"
}

####################################################################
#++++++++++++++++++++++++++++++ Main ++++++++++++++++++++++++++++++#
####################################################################
ARGS=$(getopt --options "buchv" --longoptions "build,upload,clean,help,version" -n "$name" -- "$@")
eval set -- "$ARGS"

if [[ ${#@} -lt 2 ]]; then
  helpInfo
else
  while true; do
    case $1 in
      -a | --all)
        builder
        uploader
        cleaner
        shift 1
        ;;
      -b | --build)
        builder
        shift 1
        ;;
      -u | --upload)
        uploader
        shift 1
        ;;
      -c | --clean)
        cleaner
        shift 1
        ;;
      -h | --help)
        helpInfo
        shift 1
        ;;
      -v | --version)
        versionInfo
        shift 1
        ;;
      --)
        shift 1
        break
        ;;
      *)
        helpInfo
        exit $err_unknown
        ;;
    esac
  done
fi
