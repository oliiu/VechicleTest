@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

cls
echo ==============================================
echo          Git 双平台全自动推送脚本
echo           GitHub + Gitee 一键推送
echo ==============================================
echo.
echo 【1】推送整个项目（所有变更）
echo 【2】推送单个文件
echo 【3】推送单个文件夹
echo 【4】强制覆盖远程（慎用）
echo.
set "choice="
set /p "choice=请选择操作 [1/2/3/4]："

if "%choice%"=="1" goto push_all
if "%choice%"=="2" goto push_file
if "%choice%"=="3" goto push_dir
if "%choice%"=="4" goto push_force

echo 输入错误，退出。
pause >nul
exit /b

:: ==============================================
:: 1. 推送所有变更
:: ==============================================
:push_all
echo.
set "msg="
set /p "msg=请输入提交信息："
if not defined msg set "msg=auto update"

git add .
git commit -m "%msg%"
echo.
echo ===== 推送到 GitHub =====
git push github master
echo.
echo ===== 推送到 Gitee =====
git push gitee master
goto end

:: ==============================================
:: 2. 推送单个文件
:: ==============================================
:push_file
echo.
set "file="
set /p "file=请输入文件路径（如 index.html）："
if not defined file (
    echo 未输入文件，退出。
    pause >nul
    exit /b
)

set "msg="
set /p "msg=提交信息："
if not defined msg set "msg=update %file%"

git add "%file%"
git commit -m "%msg%"
echo.
echo ===== 推送到 GitHub =====
git push github master
echo.
echo ===== 推送到 Gitee =====
git push gitee master
goto end

:: ==============================================
:: 3. 推送单个文件夹
:: ==============================================
:push_dir
echo.
set "dir="
set /p "dir=请输入文件夹名（如 src/）："
if not defined dir (
    echo 未输入文件夹，退出。
    pause >nul
    exit /b
)

set "msg="
set /p "msg=提交信息："
if not defined msg set "msg=update %dir%"

git add "%dir%/"
git commit -m "%msg%"
echo.
echo ===== 推送到 GitHub =====
git push github master
echo.
echo ===== 推送到 Gitee =====
git push gitee master
goto end

:: ==============================================
:: 4. 强制覆盖推送
:: ==============================================
:push_force
echo.
echo 警告：强制推送会覆盖远程仓库！
set "confirm="
set /p "confirm=确定继续？(y/n)："
if /i not "%confirm%"=="y" (
    echo 已取消。
    pause >nul
    exit /b
)

set "msg="
set /p "msg=提交信息："
if not defined msg set "msg=force update"

git add .
git commit -m "%msg%"
echo.
echo ===== 强制推送到 GitHub =====
git push github master -f
echo.
echo ===== 强制推送到 Gitee =====
git push gitee master -f
goto end

:end
echo.
echo 推送完成！
pause >nul