@echo off
cd /d %~dp0

echo Activating VENV
call test_env\Scripts\activate.bat
python ai_voicetalk_local.py

