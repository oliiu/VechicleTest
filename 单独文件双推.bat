@echo off
chcp 65001 >nul
cls
color 0B
echo ==============================================
echo           拖入单文件 → 自动推送
echo ==============================================
echo.

if "%~1"=="" (
    echo 请把【单个文件】拖到此脚本图标上运行！
    echo.
    pause
    exit
)

git config --global core.quotepath false
for /f %%i in ('git rev-parse --abbrev-ref HEAD') do set branch=%%i
echo 当前分支：%branch%
echo.

set "file=%~1"
echo 已拖入文件：%file%
echo.

git add "%file%"
git commit -m "单文件更新：%~nx1"
git pull origin %branch%
git push origin %branch%

echo.
echo ✅ 单文件推送成功！
echo.
pause