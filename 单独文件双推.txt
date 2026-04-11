@echo off
chcp 65001 >nul
cls

echo ==============================================
echo        单独文件提交 + GitHub + Gitee 双推
echo ==============================================
echo.

:: 检查是否拖入文件
if "%~1"=="" (
    echo 请把【要推送的文件】拖到此 bat 图标上运行！
    pause >nul
    exit /b
)

echo 正在处理文件：%~nx1
echo.

:: 1. 只添加这一个文件
echo [1/5] 正在添加单个文件...
git add "%~1"

:: 2. 提交
echo [2/5] 正在提交...
git commit -m "单独更新文件：%~nx1"

:: 3. 拉取 Gitee（防冲突）
echo [3/5] 正在拉取 Gitee 最新代码...
git pull gitee master --allow-unrelated-histories

:: 4. 推送到 GitHub
echo [4/5] 正在推送到 GitHub...
git push origin master

:: 5. 推送到 Gitee
echo [5/5] 正在推送到 Gitee...
git push gitee master

echo.
echo ==============================================
echo              ✅ 单个文件推送完成！
echo ==============================================
pause