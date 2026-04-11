@echo off
chcp 65001 >nul
echo ==============================================
echo       Git 自动拉取+提交+双平台推送脚本
echo ==============================================
echo.

:: 1. 拉取 Gitee 远程代码，解决版本落后
echo [1/5] 正在同步 Gitee 远程代码...
git pull gitee master --allow-unrelated-histories

:: 2. 添加所有本地修改
echo [2/5] 正在添加修改文件...
git add -A

:: 3. 提交代码（自动生成提交信息）
echo [3/5] 正在提交代码...
git commit -m "自动同步：%date% %time%"

:: 4. 推送到 GitHub
echo [4/5] 正在推送到 GitHub...
git push origin master

:: 5. 推送到 Gitee
echo [5/5] 正在推送到 Gitee...
git push gitee master

echo.
echo ==============================================
echo              ✅ 全部操作完成！
echo ==============================================
pause