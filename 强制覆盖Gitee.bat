@echo off
chcp 65001 >nul
cls
color 0C
echo ==============================================
echo              强制覆盖远程仓库
echo ==============================================
echo 【危险】本地代码将完全覆盖远程！
echo.

git config --global core.quotepath false
for /f %%i in ('git rev-parse --abbrev-ref HEAD') do set branch=%%i
echo 当前分支：%branch%
echo.

git add -A
git commit -m "强制覆盖提交"
git push --force origin %branch%

echo.
echo ✅ 强制覆盖完成！
echo.
pause

