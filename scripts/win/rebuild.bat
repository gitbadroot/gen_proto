@echo off

echo ===============================================================================
echo ����build������
echo ===============================================================================

set BEGDIR=%cd:\=/%

call make.bat clean

cd %BEGDIR%
call make.bat

