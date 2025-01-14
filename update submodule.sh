#!/bin/bash

# 初始化并更新所有子模块
echo "updating submodules..."
git submodule update --init --recursive
echo "update done"

echo press any button to continue...
read -n 1