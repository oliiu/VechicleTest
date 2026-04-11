@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cls

:: 输入提交日志
set "commit_msg="
set /p "commit_msg=请输入提交日志："

if not defined commit_msg (
    set "commit_msg=自动同步 %date% %time%"
)

:: 输入文件路径
echo 请输入需要推送的单个文件路径（例：index.html、test.txt）
set /p "target_file="

:: 检查是否输入文件
if not defined target_file (
    echo 错误：未输入文件路径
    pause >nul
    exit /b
)

:: 检查文件是否存在
if not exist "!target_file!" (
    echo 错误：文件不存在
    pause >nul
    exit /b
)

:: ==============================
:: 【核心修复】检查这个文件有没有修改
:: 没修改 → 直接退出，防止空提交
:: ==============================
git diff --quiet -- "!target_file!" >nul 2>nul
if %errorlevel% equ 0 (
    git ls-files --error-unmatch "!target_file!" >nul 2>nul
    if %errorlevel% equ 0 (
        echo ✅ 文件未修改，无需提交
        pause >nul
        exit /b
    )
)

:: 拉取代码
echo [1/3] 拉取最新代码...
git pull gitee master --allow-unrelated-histories

:: 提交单个文件
echo [2/3] 提交文件...
git add "!target_file!"
git commit -m "!commit_msg!"

:: 推送（删除了所有中文特殊符号，不报错）
echo [3/3] 推送到 GitHub...
git push github master

echo [3/3] 推送到 Gitee...
git push gitee master

echo.
echo ✅ 双平台推送完成！
echo 推送文件：!target_file!
pause >nul
exit /b