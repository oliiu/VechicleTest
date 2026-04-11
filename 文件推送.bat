@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 无需编辑脚本，运行后直接输入文件路径（相对路径，示例清晰，直接参考输入）
echo 请输入需要推送的单个文件路径（项目根目录相对路径，示例：index.html、js/main.js、data.csv）：
set /p "target_file="

:: 检查输入是否为空
if not defined target_file (
    echo 错误：未输入文件路径，请重新运行并输入！
    pause >nul
    exit /b
)

:: 检查文件是否存在
if not exist "%target_file%" (
    echo 错误：未找到文件 %target_file%，请检查文件路径是否正确！
    pause >nul
    exit /b
)

:: 仅提交该单个文件的变更，提交信息自动包含文件路径
git add "%target_file%"
git commit -m "update single file: %target_file%"

:: 推送到GitHub（master分支，无需交互，已默认修改）
echo 正在推送到GitHub（仅推送文件：%target_file%）...
git push github master

:: 推送到Gitee（master分支，无需交互，已默认修改）
echo 正在推送到Gitee（仅推送文件：%target_file%）...
git push gitee master

echo.
echo 双平台单文件推送完成！（推送文件：%target_file%）
pause >nul
exit /b