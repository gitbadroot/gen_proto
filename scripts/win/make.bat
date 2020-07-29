@echo off
setlocal ENABLEDELAYEDEXPANSION
set EVA=""
set MAKE_OPTS=''
PATH=C:\Program Files\erl7.3\bin;%PATH%
:MAIN
if "%1" == "" (
SET EVA="case mmake:all(8, [!MAKE_OPTS!]) of up_to_date -> halt(0); error -> halt(1) end."
call :MAKE !EVA!
) else if "%1" == "deps" (
SET EVA="case mmake:all(8, [!MAKE_OPTS!]) of up_to_date -> halt(0); error -> halt(1) end."
call :MAKEDEPS !EVA!
) else if "%1" == "py" (
python make.py
) else if "%1" == "debug" (
set MAKE_OPTS=!MAKE_OPTS!,debug_info
SET EVA="case mmake:all(8, [!MAKE_OPTS!]) of up_to_date -> halt(0); error -> halt(1) end."
call :MAKE !EVA!
) else if "%1" == "clean" (
call :CLEAN
) else (
echo ��������!
echo ===============================================================================
echo Ĭ�ϱ���:          make
echo ����ͷ�ļ�����:    make py
echo ����debug�汾:     make debug
echo ��ձ����beam:    make clean
)
GOTO :EOF

rem ���beam
:CLEAN
del ..\ebin\game\*.beam
echo ��ձ����ļ� ok!
GOTO :EOF

rem ����
:MAKE
echo ��ʼ���룬����رմ��ڣ�
cd ..
erl -pa "./deps/make" -noinput -eval %1
if "%errorlevel%" == "0" (echo �ļ�����ɹ���
) else (echo �ļ�����ʧ�ܣ�%errorlevel%)
pause
GOTO :EOF

rem make deps
:MAKEDEPS
cd ../deps/
erl -pa "./make" -noinput -eval %1
pause
GOTO :EOF