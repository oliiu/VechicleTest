@echo off
chcp 65001 >nul
cls
color 0A
echo ==============================================
echo           Git 终极一键推送（永不报错版）
echo ==============================================
echo.

:: 解决中文乱码
git config --global core.quotepath false

:: ==============================================
:: 自动获取当前分支名称（智能识别 main / master）
:: ==============================================
for /f %%i in ('git rev-parse --abbrev-ref HEAD') do set branch=%%i
echo 当前分支：%branch%
echo.

:: 拉取最新代码
echo 【1/4】拉取最新代码...
git pull origin %branch%

:: 添加所有变更（新文件 + 修改文件 + 删除文件）
echo.
echo 【2/4】添加所有文件变更...
git add -A

:: 提交
echo.
echo 【3/4】自动提交中...
git commit -m "自动更新：%date% %time%"

:: 推送到当前分支
echo.
echo 【4/4】推送中...
git push origin %branch%

echo.
echo ==============================================
echo              ✅ 推送完成！
echo ==============================================
echo.
pause