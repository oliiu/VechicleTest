@echo off
chcp 65001 >nul
echo 正在强制覆盖 Gitee 远程仓库...
git push gitee master --force
echo ✅ 强制覆盖完成！现在可以正常推送了
pause