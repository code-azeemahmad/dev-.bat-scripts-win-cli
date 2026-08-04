:: (Quick Virtual Environment Activation)
@echo off
if exist .venv\Scripts\activate.bat (
    call .venv\Scripts\activate.bat
    echo [OK] Activated .venv
) else if exist venv\Scripts\activate.bat (
    call venv\Scripts\activate.bat
    echo [OK] Activated venv
) else if exist env\Scripts\activate.bat (
    call env\Scripts\activate.bat
    echo [OK] Activated env
) else (
    echo [Error] No virtual environment found in this directory.
)