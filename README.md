# Local AI Voice Chat 

Talk in realtime with AI, completely local on your PC. With customizable AI personality and voice.

## About the Project

Integrates the powerful Zephyr 7B language model with real-time speech-to-text and text-to-speech libraries to create a fast and engaging voicebased local chatbot. 

## Tech Stack

- **[llama_cpp](https://github.com/ggerganov/llama.cpp)**: A C++ library interface for the Llama language model.
- **[RealtimeSTT](https://github.com/KoljaB/RealtimeSTT)**: Real-time speech-to-text transcription library.
- **[RealtimeTTS](https://github.com/KoljaB/RealtimeTTS)**: Real-time text-to-speech synthesis library.

## Setup Instructions

### Prerequisites

You will need a GPU with around 8 GB VRAM to run this in real-time.

- **NVIDIA CUDA Toolkit 11.8**:
    - Access the [NVIDIA CUDA Toolkit Archive](https://developer.nvidia.com/cuda-11-8-0-download-archive).
    - Choose version 11.x and follow the instructions for downloading and installation.

- **NVIDIA cuDNN 8.7.0 for CUDA 11.x**:
    - Navigate to [NVIDIA cuDNN Archive](https://developer.nvidia.com/rdp/cudnn-archive).
    - Locate and download "cuDNN v8.7.0 (November 28th, 2022), for CUDA 11.x".
    - Follow the provided installation guide.

- **FFmpeg**:

    Install FFmpeg according to your operating system:

    - **Ubuntu/Debian**:
        ```shell
        sudo apt update && sudo apt install ffmpeg
        ```

    - **Arch Linux**:
        ```shell
        sudo pacman -S ffmpeg
        ```

    - **macOS (Homebrew)**:
        ```shell
        brew install ffmpeg
        ```

    - **Windows (Chocolatey)**:
        ```shell
        choco install ffmpeg
        ```

    - **Windows (Scoop)**:
        ```shell
        scoop install ffmpeg
        ```    

### Installation Steps 

1. Clone the repository or download the source code package.

2. Run the `install_win.bat` script. This will automatically handle the installation of required dependencies and prepare your environment. There may be warnings about numpy or fsspec incompatibilies, but you can ignore them, it will work nevertheless.

If you are running UNIX or MAC you need to adjust this script (if someone with more experience under these platforms could mail me install-scripts, I would love to add them for these platforms).

3. Download zephyr-7b-beta.Q5_K_M.gguf from [here](https://huggingface.co/TheBloke/zephyr-7B-beta-GGUF/tree/main). 
   - Open creation_params.json and enter the filepath to the downloaded model into `model_path`.
   - Adjust n_gpu_layers (0-35, raise if you have more VRAM) and n_threads (number of CPU threads, i recommend not using all available cores but leave some for TTS)

4. Implement a temporary workaround for an issue in the Coqui TTS library:
   - Activate your venv (test_env\Scripts\activate.bat under Windows, I think source test_env/bin/activate under Unix/Mac)
   - Execute the command `pip show tts` to find the installation path of the Coqui TTS library.
   - Navigate to the Coqui installation directory and proceed to `TTS/tts/models`.
   - Locate and open the `xtts.py` file in a text editor with administrative or sufficient privileges.
   - Within the `handle_chunks` method, modify the line `if wav_overlap is not None:` to `if wav_overlap is not None and wav_chunk.shape[0] > 0:`.
   
   **Note**: This modification addresses a specific runtime issue I encountered during working with the coqui library. Although it resolves the problem, it is a provisional solution. I did not consider a pull request submission to the Coqui TTS repository yet, because I honestly do not fully understand the underlying cause and full implications of the change to even document it well. This adjustment ensures functionality but should be approached with caution and technical oversight.        

## Running the Application

To start the AI voice chat, run `start.bat`. 

## Customize

### Change AI personality

Open chat_params.json to change the talk scenario.

### Change AI Voice

- Open ai_voicetalk_local.py. 
- Find this line: coqui_engine = CoquiEngine(cloning_reference_wav="female.wav", language="en")
- Change "female.wav" to the filename of a wave file (44100 or 22050 Hz mono 16-bit) containing the voice to clone

## Contributing

Contributions to enhance or improve the project are warmly welcomed. Feel free to open a pull request with your proposed changes or fixes.

## License

The project is open-sourced under the MIT License. 

## Contact

Kolja Beigel  
- Email: [kolja.beigel@web.de](mailto:kolja.beigel@web.de)  
- GitHub: [KoljaB](https://github.com/KoljaB/RealtimeTTS)

Feel free to reach out for any queries or support related to this project.