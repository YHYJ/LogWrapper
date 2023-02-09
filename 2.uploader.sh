#!/usr/bin/env bash

: << !
Name: 2.uploader.sh
Author: YJ
Email: yj1516268@outlook.com
Created Time: 2023-02-08 16:47:24

Description: 上传构建好的Python包

Attentions:
-

Depends:
-
!

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

python3 -m pip install --upgrade twine
python3 -m twine upload --repository pypi dist/*
