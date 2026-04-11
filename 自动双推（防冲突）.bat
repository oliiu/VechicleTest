@echo off
chcp 65001 >nul
echo ==============================================
echo       Git 自动拉取+提交+双平台推送脚本
echo ==============================================
echo.

:: 让你自定义输入提交日志
set /p commit_msg="请输入本次提交说明（例如：更新脚本、修复bug）："

:: 如果没输入，自动给一个默认值
if "%commit_msg%"=="" (
    set commit_msg=自动同步：%date% %time%
)

echo.
echo [1/5] 正在同步 Gitee 远程代码...
git pull gitee master --allow-unrelated-histories

echo [2/5] 正在添加所有文件...
git add -A

echo [3/5] 正在提交代码：%commit_msg%
git commit -m "%commit_msg%"

echo [4/5] 正在推送到 GitHub...
git push origin master

echo [5/5] 正在推送到 Gitee...
git push gitee master

echo.
echo ==============================================
echo              ✅ 全部操作完成！
echo ==============================================
pause