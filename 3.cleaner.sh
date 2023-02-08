#!/usr/bin/env bash

: << !
Name: 3.cleaner.sh
Author: YJ
Email: yj1516268@outlook.com
Created Time: 2023-02-08 16:54:12

Description: 清除构建生成的文件

Attentions:
-

Depends:
-
!

rm -rf dist src/logwrapper.egg-info
