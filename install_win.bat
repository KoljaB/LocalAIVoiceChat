REM FIRST install NVIDIA CUDA Toolkit 11.8, NVIDIA cuDNN 8.7.0 for CUDA 11.x and ffmpeg


@echo off
cd /d %~dp0

if not exist test_env\Scripts\python.exe (
    echo Creating VENV
    python -m venv test_env
) else (
    echo VENV already exists
)


echo Activating VENV
call test_env\Scripts\activate.bat

set LLAMA_CUBLAS=1
set FORCE_CMAKE=1
set CMAKE_ARGS=-DLLAMA_CUBLAS=on


REM upgrade pip
REM -----------------------------------

python.exe -m pip install --upgrade pip


REM install realtime libraries
REM -----------------------------------

pip install RealtimeSTT==0.1.6
pip install RealtimeTTS==0.1.7


REM torch with GPU support
REM -----------------------------------

REM https://pytorch.org/get-started/locally/

pip3 install torch torchvision torchaudio --upgrade --force-reinstall --index-url https://download.pytorch.org/whl/cu118


REM install llama with cuBLAS
REM -----------------------------------
REM https://github.com/jllllll/llama-cpp-python-cuBLAS-wheels

python -m pip install llama-cpp-python --prefer-binary --extra-index-url=https://jllllll.github.io/llama-cpp-python-cuBLAS-wheels/AVX2/cu118

pip install networkx==2.8.8
pip install typing_extensions==4.8.0
pip install fsspec==2023.6.0
pip install imageio==2.31.6
pip install networkx==2.8.8
pip install numpy==1.24.3
pip install requests==2.31.0

pause
