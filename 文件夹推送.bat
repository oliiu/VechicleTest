@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 无需编辑脚本，运行后直接输入文件夹路径（相对路径，示例清晰，直接参考输入）
echo 请输入需要推送的文件夹路径（项目根目录相对路径，示例：static、css、data，末尾无需加斜杠）：
set /p "target_folder="

:: 检查输入是否为空
if not defined target_folder (
    echo 错误：未输入文件夹路径，请重新运行并输入！
    pause >nul
    exit /b
)

:: 检查文件夹是否存在
if not exist "%target_folder%" (
    echo 错误：未找到文件夹 %target_folder%，请检查文件夹路径是否正确！
    pause >nul
    exit /b
)


:: ==============================================
:: 第一步：输入提交日志
:: ==============================================
set "commit_msg="
set /p "commit_msg=📝 请输入本次提交说明："



:: 如果没输入，使用默认日志
if not defined commit_msg (
    set "commit_msg=自动同步 %date% %time%"
)

echo.
echo ==============================================
echo 提交说明：%commit_msg%
echo ==============================================
echo.

:: 1. 拉取 Gitee 最新代码
echo [1/4] 正在同步 Gitee 远程代码...
git pull gitee master --allow-unrelated-histories

:: ==============================================
:: 第二步：检查是否有文件修改（防止空提交）
:: ==============================================
git status --porcelain | findstr . >nul 2>nul
if %errorlevel% equ 1 (
    echo ✅ 没有任何文件变更，自动退出。
    pause >nul
    exit
)

:: 仅提交该文件夹下的所有变更，提交信息自动包含文件夹路径
git add "%target_folder%/"
git commit -m "update folder: %target_folder%"

git status --porcelain | findstr . >nul 2>nul
if %errorlevel% equ 1 (
    echo ❌ 错误：文件添加失败，无法提交！
    pause >nul
    exit
)

:: 推送到GitHub（master分支，无需交互，已默认修改）
echo [2/4]正在推送到GitHub（仅推送文件夹：%target_folder%）...
git push github master

:: 推送到Gitee（master分支，无需交互，已默认修改）
echo [3/4]正在推送到Gitee（仅推送文件夹：%target_folder%）...
git push gitee master

echo.
echo [4/4]双平台文件夹推送完成！（推送文件夹：%target_folder%）
pause >nul
exit /b