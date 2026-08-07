@echo off
setlocal EnableDelayedExpansion

:: The folder where you run copycodefiles (used for scanning files)
set "ROOT=%CD%"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"

:: ANCHOR = the folder whose name onward gets shown in headers.
:: Change the number of "\.." segments to control how many parent
:: folders get included, e.g.:
::   %ROOT%        -> just "services\user_service.py"
::   %ROOT%\..     -> "app\services\user_service.py"
::   %ROOT%\..\..  -> "final_project\app\services\user_service.py"
set "ANCHOR=%ROOT%\..\.."
for %%D in ("%ANCHOR%") do set "ANCHOR=%%~fD"
if "%ANCHOR:~-1%"=="\" set "ANCHOR=%ANCHOR:~0,-1%"

:: Compute length of ANCHOR once (this is what REL is built from)
set "RLEN=0"
:LENLOOP
if not "!ANCHOR:~%RLEN%,1!"=="" (
    set /a RLEN+=1
    goto LENLOOP
)

set "TEMPFILE=%TEMP%\copycodefiles_temp.txt"
del "%TEMPFILE%" >nul 2>&1

:: Folders to ignore (matched as \NAME\ anywhere in the path)
set "EXCLUDE_DIRS=.gitignore node_modules venv .venv env bin obj dist build __pycache__ copy_code_files .db .vscode .idea"
:: Exact filenames to ignore (matched at the end of the path)
set "EXCLUDE_FILES=copycodefiles.bat __init__.py"

if not "%~1"=="" (
    set "EXT=%~1"
    for /r %%F in (*.!EXT!) do call :PROCESS "%%~fF"
)
if not "%~1"=="" goto FINISH

for /r %%F in (
    *.c *.cpp *.h *.hpp
    *.cs
    *.java *.kt
    *.py
    *.js *.jsx
    *.ts *.tsx
) do call :PROCESS "%%~fF"

:FINISH
if exist "%TEMPFILE%" (
    type "%TEMPFILE%" | clip
    del "%TEMPFILE%" >nul 2>&1
)
echo Code copied to clipboard!
exit /b

:PROCESS
set "FILE=%~1"
set "SKIP=0"

:: --- Exclude by folder name anywhere in the path ---
for %%I in (%EXCLUDE_DIRS%) do (
    set "CHECK=!FILE:\%%I\=!"
    if not "!CHECK!"=="!FILE!" set "SKIP=1"
)

:: --- Exclude by exact filename at the end of the path ---
for %%I in (%EXCLUDE_FILES%) do (
    call :ENDSWITH "!FILE!" "\%%I" RESULT
    if "!RESULT!"=="1" set "SKIP=1"
)

if "!SKIP!"=="1" exit /b

:: Build relative path via substring math
set /a "OFFSET=RLEN+1"
set "REL=!FILE:~%OFFSET%!"

(
echo ===========!REL!===============
type "!FILE!"
echo.
echo.
)>>"%TEMPFILE%"
exit /b

:: ============================
:: Check if %1 ends with %2 (case-insensitive), result in %3
:: ============================
:ENDSWITH
setlocal EnableDelayedExpansion
set "STR=%~1"
set "SUFFIX=%~2"
set "SLEN=0"
:ENDSWITH_LEN
if not "!SUFFIX:~%SLEN%,1!"=="" (
    set /a SLEN+=1
    goto ENDSWITH_LEN
)
set /a "TAILSTART=SLEN*-1"
set "TAIL=!STR:~%TAILSTART%!"
if /i "!TAIL!"=="!SUFFIX!" (
    endlocal & set "%~3=1"
) else (
    endlocal & set "%~3=0"
)
exit /b


::  *.html *.htm
::  *.css *.scss *.sass
::  *.json *.xml *.yaml *.yml
::  *.sql
::  *.php
::  *.go
::  *.rs
::  *.swift
::  *.dart
::  *.sh
::  *.ps1
::  *.bat
::  *.cmd
::  *.md