# 🚀 Git 常用命令速查表

---

## 🔧 一、初始化 & 克隆

| 操作           | 命令                                   | 示例 |
|----------------|----------------------------------------|------|
| 初始化仓库      | `git init`                             | `git init` |
| 克隆远程仓库    | `git clone <仓库地址>`                  | `git clone https://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/demo-repo` |

---

## 📝 二、修改代码 & 提交

| 操作           | 命令                                   | 示例 |
|----------------|----------------------------------------|------|
| 查看状态        | `git status`                           | |
| 添加单个文件    | `git add <文件>`                        | `git add app.js` |
| 添加全部文件    | `git add .`                             | |
| 提交更改        | `git commit -m "提交说明"`               | `git commit -m "修复登录 bug"` |

---

## 🔁 三、查看 & 撤销修改

| 操作                | 命令                                   | 示例 |
|---------------------|----------------------------------------|------|
| 查看提交历史         | `git log`                              | |
| 撤销工作区更改       | `git checkout -- <文件>`                | `git checkout -- app.js` |
| 撤销已添加文件       | `git reset`                            | |
| 撤销最近一次提交（保留更改）| `git reset --soft HEAD~1`       | |

---

## 🌳 四、分支操作

| 操作           | 命令                                   | 示例 |
|----------------|----------------------------------------|------|
| 查看所有分支    | `git branch`                           | |
| 创建分支        | `git branch <分支名>`                   | `git branch dev` |
| 切换分支        | `git checkout <分支名>`                 | `git checkout dev` |
| 创建并切换分支  | `git checkout -b <分支名>`              | `git checkout -b dev` |
| 合并分支        | `git merge <分支名>`                    | `git merge dev` |
| 删除分支        | `git branch -d <分支名>`                | `git branch -d dev` |

---

## ⬆️⬇️ 五、远程仓库交互

| 操作             | 命令                                        | 示例 |
|------------------|---------------------------------------------|------|
| 查看远程地址     | `git remote -v`                              | |
| 添加远程仓库     | `git remote add origin <地址>`               | `git remote add origin https://...` |
| 修改远程地址     | `git remote set-url origin <新地址>`         | |
| 推送分支         | `git push origin <分支名>`                    | `git push origin main` |
| 推送新分支       | `git push -u origin <分支名>`                 | `git push -u origin dev` |
| 拉取更新         | `git pull`                                   | |
| 拉取指定分支     | `git pull origin <分支名>`                    | `git pull origin main` |

---

## 🧰 暂存改动（stash）

| 操作                     | 命令                                      | 示例 |
|--------------------------|-------------------------------------------|------|
| 保存当前更改             | `git stash`                               | |
| 恢复最近 stash           | `git stash pop`                           | |
| 查看所有 stash 记录      | `git stash list`                          | |
| 应用某个 stash（不删除） | `git stash apply stash@{1}`               | |
| 删除某个 stash           | `git stash drop stash@{1}`                | |
| 清空所有 stash           | `git stash clear`                         | |

---

## 🧾 修改历史记录

| 操作                     | 命令                                      | 示例 |
|--------------------------|-------------------------------------------|------|
| 修改最近一次 commit 信息 | `git commit --amend -m "新说明"`           | |
| 合并多个 commit（压缩） | `git rebase -i HEAD~3`                    | |
| 修改历史 commit          | `git rebase -i`，改 `pick` 为 `edit`       | |

---

## 🔁 回退版本

| 操作                     | 命令                                      | 示例 |
|--------------------------|-------------------------------------------|------|
| 查看历史（简略）        | `git log --oneline`                       | |
| 回退到某版本（保留更改）| `git reset --soft <commit_hash>`         | |
| 回退到某版本（彻底清除）| `git reset --hard <commit_hash>`         | |
| 生成反向提交（撤销）    | `git revert <commit_hash>`               | |

---

## 🔍 差异对比 & 文件追踪

| 操作                     | 命令                                      | 示例 |
|--------------------------|-------------------------------------------|------|
| 查看当前改动差异         | `git diff`                                | |
| 查看暂存区差异           | `git diff --cached`                       | |
| 对比两个版本差异         | `git diff <版本1> <版本2>`                | |
| 查看文件提交历史         | `git log <文件>`                          | |
| 查看每行作者             | `git blame <文件>`                        | |

---

## 🔧 常用配置

| 操作                    
|----------------------------------------------|
|git config --global user.name "你的名字"      |
|git config --global user.email "你@邮箱.com"  |
|git config --global core.autocrlf true       |
|git config --global color.ui auto            |
|git config --global init.defaultBranch main  |
|git config --list  # 查看全部配置             |

---

## 📂 忽略文件 `.gitignore` 示例

```gitignore
# 忽略依赖目录
node_modules/

# 忽略日志文件
*.log

# 忽略操作系统文件
.DS_Store
Thumbs.db
