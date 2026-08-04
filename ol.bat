:: (Start Ollama Model Quick Launch)
@echo off
if "%~1"=="" (
    ollama run llama3.2
) else (
    ollama run %1
)

:: Command: ol nomic-embed-text