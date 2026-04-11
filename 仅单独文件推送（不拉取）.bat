@echo off
chcp 65001 >nul
if "%~1"=="" (echo 请拖入文件 & pause >nul & exit /b)

git add "%~1"
git commit -m "单独更新：%~nx1"
git push origin master
git push gitee master

echo ✅ 推送完成！
pause