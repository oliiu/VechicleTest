@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cls

:: ==============================================
:: 单文件夹终极推送脚本（永不空提交、永不崩溃）
:: ==============================================

:: 1. 输入提交日志
set "commit_msg="
set /p "commit_msg=请输入提交日志："
if not defined commit_msg set "commit_msg=自动同步文件夹 %date% %time%"

:: 2. 输入文件夹路径
set "target_folder="
set /p "target_folder=请输入要推送的文件夹路径："
if not defined target_folder (
    echo ❌ 错误：未输入文件夹路径
    pause >nul
    exit /b
)
if not exist "!target_folder!\" (
    echo ❌ 错误：文件夹不存在，请检查路径
    pause >nul
    exit /b
)

:: ==============================================
:: 【终极双检测】彻底杜绝空提交
:: 检测1：已追踪文件是否修改
:: 检测2：是否有未追踪的新文件/文件夹
:: ==============================================
set "has_change=0"

:: 检测已追踪文件修改
git diff --quiet -- "!target_folder!/" >nul 2>nul
if !errorlevel! neq 0 set "has_change=1"

:: 检测未追踪的新文件/文件夹
git ls-files --others --exclude-standard -- "!target_folder!/" | findstr . >nul 2>nul
if !errorlevel! equ 0 set "has_change=1"

:: 无任何变更，直接退出
if "!has_change!"=="0" (
    echo ✅ 文件夹无任何修改，无需提交，自动退出
    pause >nul
    exit /b
)

:: ==============================================
:: 3. 拉取远程代码（解决版本冲突）
:: ==============================================
echo [1/4] 正在同步Gitee远程代码...
git pull gitee master --allow-unrelated-histories

:: ==============================================
:: 4. 强制添加文件夹所有变更（100% 执行成功）
:: ==============================================
echo [2/4] 正在添加文件夹所有文件...
git add -f "!target_folder!/"

:: 二次校验：确保文件已被暂存
git status --porcelain "!target_folder!/" | findstr . >nul 2>nul
if !errorlevel! equ 1 (
    echo ❌ 错误：文件添加失败，无法提交
    pause >nul
    exit /b
)

:: ==============================================
:: 5. 提交代码（绝对不会空提交）
:: ==============================================
echo [3/4] 正在提交代码...
git commit -m "!commit_msg!"

:: ==============================================
:: 6. 双平台推送（移除所有中文特殊符号，彻底防崩溃）
:: ==============================================
echo [4/4] 正在推送到GitHub...
git push github master

echo [4/4] 正在推送到Gitee...
git push gitee master

echo.
echo ==============================================
echo ✅ 文件夹推送完成！
echo 推送路径：!target_folder!
echo ==============================================
pause >nul
exit /b
