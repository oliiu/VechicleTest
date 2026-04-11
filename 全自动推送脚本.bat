@echo off
chcp 65001 >nul
cls
color 0A
echo ==============================================
echo           Git 全自动一键推送（修复版）
echo ==============================================
echo.

:: 解决中文乱码
git config --global core.quotepath false

echo 【1/4】拉取最新代码...
git pull origin main
if %errorlevel% neq 0 git pull origin master

echo.
echo 【2/4】添加所有修改 & 新增文件...
git add -A      <-- 关键修复：强制提交所有变更

echo.
echo 【3/4】自动提交变更...
git commit -m "自动更新：%date% %time%"

echo.
echo 【4/4】推送到远程仓库...
git push origin main
if %errorlevel% neq 0 git push origin master

echo.
echo ==============================================
echo              ✅ 全部文件更新完成！
echo ==============================================
echo.
pause