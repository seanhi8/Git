#!/bin/bash

set -e

echo "=== AWS CodeCommit SSH 配置辅助脚本 ==="

KEY_PATH="$HOME/.ssh/id_rsa"
CONFIG_FILE="$HOME/.ssh/config"

# 1. 检查是否已有 SSH Key
if [ -f "$KEY_PATH" ]; then
  echo "发现已有 SSH 私钥：$KEY_PATH"
  read -p "是否覆盖？(y/N): " overwrite
  if [[ "$overwrite" =~ ^[Yy]$ ]]; then
    echo "覆盖旧密钥..."
    rm -f "$KEY_PATH" "$KEY_PATH.pub"
  else
    echo "使用已有密钥，跳过生成步骤。"
  fi
fi

# 2. 生成 SSH Key（如果没有或选择覆盖）
if [ ! -f "$KEY_PATH" ]; then
  echo "生成新的 SSH Key..."
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f "$KEY_PATH" -N ""
  echo "SSH Key 生成完毕。"
fi

# 3. 显示公钥内容，提醒上传
echo "请复制以下公钥内容，上传到 AWS IAM 用户的 SSH 公钥中："
echo "----- 公钥内容开始 -----"
cat "${KEY_PATH}.pub"
echo "----- 公钥内容结束 -----"
echo "请登录 https://console.aws.amazon.com/iam/ ，找到你的用户，上传公钥。"
read -p "确认已经上传公钥？(y/N): " uploaded
if [[ ! "$uploaded" =~ ^[Yy]$ ]]; then
  echo "请先上传公钥后再运行本脚本。退出。"
  exit 1
fi

# 4. 让用户输入 SSH 公钥 ID（AWS 给你的那个ID）
read -p "请输入 AWS IAM 中显示的 SSH 公钥 ID（例如 APKAEIBAERJR2EXAMPLE）: " SSH_KEY_ID
if [ -z "$SSH_KEY_ID" ]; then
  echo "SSH 公钥 ID 不能为空。退出。"
  exit 1
fi

# 5. 配置 ~/.ssh/config
echo "开始配置 SSH config 文件..."

if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

if [ ! -f "$CONFIG_FILE" ]; then
  touch "$CONFIG_FILE"
  chmod 600 "$CONFIG_FILE"
fi

# 先备份配置文件
cp "$CONFIG_FILE" "$CONFIG_FILE.bak.$(date +%s)"

# 去掉已有相关配置，避免重复
grep -v "Host git-codecommit.*.amazonaws.com" "$CONFIG_FILE" > "$CONFIG_FILE.tmp" || true
mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

# 添加新配置
cat >> "$CONFIG_FILE" << EOF

Host git-codecommit.*.amazonaws.com
  User $SSH_KEY_ID
  IdentityFile $KEY_PATH
EOF

echo "SSH 配置文件更新完毕，备份存于 ${CONFIG_FILE}.bak.*"

# 6. 测试 SSH 连接
echo "开始测试 SSH 连接..."

ssh -o StrictHostKeyChecking=no git-codecommit.ap-northeast-1.amazonaws.com || {
  echo "SSH 连接失败，请检查配置和网络。"
  exit 1
}

echo "SSH 连接成功！你现在可以用 SSH URL 克隆仓库了。"
echo "例如："
echo "git clone ssh://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/你的仓库名"

echo "脚本执行完毕！"
