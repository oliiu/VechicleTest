@echo off
chcp 65001 >nul
cls
echo ==============================================
echo       Git 自动拉取+提交+双平台推送脚本
echo ==============================================
echo.

:: 在这里等待你输入提交说明
set "commit_msg="
set /p "commit_msg=📝 请输入提交日志："

:: 如果你什么都不输入，自动使用默认日志
if not defined commit_msg (
    set "commit_msg=自动同步 %date% %time%"
)

echo.
echo ==============================================
echo 本次提交说明：%commit_msg%
echo ==============================================
echo.

git status --porcelain | findstr . >nul 2>nul
if %errorlevel% equ 1 (
    echo ✅ 没有任何文件变更，脚本自动退出。
    pause >nul
    exit
)


:: 开始执行
echo [1/4] 拉取最新代码...
git pull gitee master --allow-unrelated-histories

echo [2/4] 添加所有文件...
git add -A

echo [3/4] 提交中...
git commit -m "%commit_msg%"

echo [4/4] 双平台推送中...
git push origin master
git push gitee master

echo.
echo ==============================================
echo              ✅ 全部完成！
echo ==============================================
pause