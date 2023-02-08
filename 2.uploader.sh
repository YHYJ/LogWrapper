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

python3 -m pip install --upgrade twine
python3 -m twine upload --repository pypi dist/*
