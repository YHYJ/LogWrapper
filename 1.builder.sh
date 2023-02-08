#!/usr/bin/env bash

: << !
Name: 1.builder.sh
Author: YJ
Email: yj1516268@outlook.com
Created Time: 2023-02-08 16:46:28

Description: 构建Python包

Attentions:
-

Depends:
-
!

python3 -m pip install --upgrade build
python3 -m build
