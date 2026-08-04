:: (Pipe Any Code File to Clipboard)
@echo off
if "%~1"=="" (
    echo Usage: clipcode ^<filename^>
    exit /b 1
)
type %1 | clip
echo [OK] Copied %1 to clipboard!

:: Command: clipcode app\main.py