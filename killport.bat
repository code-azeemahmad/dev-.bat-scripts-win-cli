:: (Kill Stuck Uvicorn or FastApi Server)
@echo off
if "%~1"=="" (
    set PORT=8000
) else (
    set PORT=%1
)

echo Finding process on port %PORT%...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :%PORT% ^| findstr LISTENING') do (
    echo Killing PID %%a...
    taskkill /F /PID %%a
)
echo [OK] Port %PORT% cleared!

:: Command: killport (clears port 8000) or killport 6333