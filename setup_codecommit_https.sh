#!/bin/bash

set -e

echo "=== AWS CodeCommit HTTPS 认证配置脚本 ==="

# 1. 检查 aws 命令是否存在
if ! command -v aws &> /dev/null; then
  echo "未检测到 AWS CLI，开始安装..."
  # MacOS brew 安装示例（Linux 请根据系统改动）
  if command -v brew &> /dev/null; then
    brew install awscli
  else
    echo "请先安装 AWS CLI，参见 https://aws.amazon.com/cli/"
    exit 1
  fi
else
  echo "检测到 AWS CLI 已安装。"
fi

# 2. 配置 AWS CLI（会提示输入密钥等）
echo "请开始配置 AWS CLI 访问凭证"
aws configure

# 3. 配置 Git 使用 AWS CodeCommit 凭证助手
echo "配置 Git 使用 AWS CodeCommit 凭证助手..."

git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true

echo "配置完成！"

echo ""
echo "你现在可以用 HTTPS URL 克隆仓库，例如："
echo "https://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/你的仓库名"
echo ""
echo "执行命令示例："
echo "git clone https://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/你的仓库名"
