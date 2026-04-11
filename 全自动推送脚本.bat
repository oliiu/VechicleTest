@echo off
chcp 65001 >nul
cls
color 0A
echo ==============================================
echo           Git 全自动一键推送脚本
echo ==============================================
echo.

:: 解决中文文件名乱码
git config --global core.quotepath false

echo 1. 拉取远程最新代码...
git pull origin main
if %errorlevel% neq 0 (
    echo 拉取失败，尝试 master 分支...
    git pull origin master
)

echo.
echo 2. 添加所有文件到暂存区...
git add .

echo.
echo 3. 自动提交...
git commit -m "自动提交：%date% %time%"

echo.
echo 4. 推送到远程仓库...
git push origin main
if %errorlevel% neq 0 (
    echo 推送失败，尝试 master 分支...
    git push origin master
)

echo.
echo ==============================================
echo              ✅ 推送完成！
echo ==============================================
echo.
pause