:: (Clean Python Caches & Build Artifacts)
echo off
echo Cleaning Python cache and build files...
for /d /r . %%d in (__pycache__) do @if exist "%%d" rd /s /q "%%d"
for /d /r . %%d in (.pytest_cache) do @if exist "%%d" rd /s /q "%%d"
for /d /r . %%d in (.mypy_cache) do @if exist "%%d" rd /s /q "%%d"
del /s /q /f *.pyc >nul 2>&1
echo [OK] Cleanup complete!