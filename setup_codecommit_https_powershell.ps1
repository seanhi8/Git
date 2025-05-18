Write-Host "=== AWS CodeCommit HTTPS 认证配置脚本 for Windows ===" -ForegroundColor Cyan

# 1. 检查 AWS CLI 是否安装
$awsCli = Get-Command aws -ErrorAction SilentlyContinue
if (-not $awsCli) {
    Write-Host "未检测到 AWS CLI。" -ForegroundColor Yellow
    Write-Host "请先手动安装：https://docs.aws.amazon.com/zh_cn/cli/latest/userguide/getting-started-install.html" -ForegroundColor Red
    exit
} else {
    Write-Host "已检测到 AWS CLI。"
}

# 2. 配置 AWS CLI
Write-Host "`n开始配置 AWS CLI..."
Start-Process powershell -ArgumentList "aws configure" -Wait

# 3. 配置 Git 凭证助手
Write-Host "`n配置 Git 使用 AWS CodeCommit 凭证助手..."
git config --global credential.helper "!aws codecommit credential-helper $@"
git config --global credential.UseHttpPath true
Write-Host "Git 凭证助手配置完成。" -ForegroundColor Green

# 4. 显示克隆仓库说明
Write-Host "`n你现在可以使用 HTTPS 克隆 CodeCommit 仓库，例如：" -ForegroundColor Cyan
Write-Host "git clone https://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/你的仓库名" -ForegroundColor Yellow
