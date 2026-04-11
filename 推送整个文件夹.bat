@echo off
chcp 65001 >nul
cls

echo ==============================================
echo          推送整个文件夹到 GitHub + Gitee
echo ==============================================
echo.

if "%~1"=="" (
    echo 请把【要推送的文件夹】拖到此脚本上！
    pause >nul
    exit /b
)

echo 正在推送文件夹：%~1
echo.

git add "%~1\"
git commit -m "提交文件夹：%~1"
git pull gitee master --allow-unrelated-histories
git push origin master
git push gitee master

echo.
echo ✅ 文件夹推送完成！
pause
