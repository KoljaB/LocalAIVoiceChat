@echo off
cd /d %~dp0

if not exist test_env\Scripts\python.exe (
    echo Creating VENV
    python -m venv test_env
) else (
    echo VENV already exists
)

echo Activating VENV
start cmd /k call test_env\Scripts\activate.bat

