# Local AI Voice Chat 

Provides talk in realtime with AI, completely local on your PC, with customizable AI personality and voice.

## About the Project

Integrates the powerful Zephyr 7B language model with real-time speech-to-text and text-to-speech libraries to create a fast and engaging voicebased local chatbot. 

https://github.com/KoljaB/LocalAIVoiceChat/assets/7604638/cebacdad-8a57-4a03-bfd1-a469730dda51

## Tech Stack

- **[llama_cpp](https://github.com/ggerganov/llama.cpp)** with Zephyr 7B  
  - library interface for llamabased language models
- **[RealtimeSTT](https://github.com/KoljaB/RealtimeSTT)** with faster_whisper  
  - real-time speech-to-text transcription library
- **[RealtimeTTS](https://github.com/KoljaB/RealtimeTTS)** with Coqui XTTS  
  - real-time text-to-speech synthesis library

## Notes

This software is in an experimental alpha state and does not provide production ready stability. The current XTTS model used for synthesis still has glitches and also Zephyr - while really good for a 7B model - of course can not compete with the answer quality of GPT 4, Claude or Perplexity.

Please take this as a first attempt to provide an early version of a local realtime chatbot.

### Updates

- Bugfix to RealtimeTTS (download of Coqui model did not work properly)

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

2. For Windows users, execute the `install_win.bat` script to install required dependencies and set up the environment. You may encounter warnings regarding `numpy` or `fsspec` incompatibilities; however, these can be ignored as the installation should still function correctly. If this fails on your machine, activate your venv with `test_env\Scripts\activate.bat` and try to install the libraries like described for UNIX-Installation.

   For UNIX or MAC users (note that these steps are untested), it is recommended to create a virtual environment and then install the necessary libraries:
   
   - Create and activate a virtual environment:
     ```
     python3 -m venv test_env
     source test_env/bin/activate
     ```

   - Install the main libraries:
     ```
     pip install RealtimeSTT==0.1.6
     pip install RealtimeTTS==0.1.7
     pip install llama-cpp-python --force-reinstall --upgrade --no-cache-dir --verbose
     ```

   - If dependency conflicts occur, install specific versions of conflicting libraries:
     ```
     pip install networkx==2.8.8
     pip install typing_extensions==4.8.0
     pip install fsspec==2023.6.0
     pip install imageio==2.31.6
     pip install numpy==1.24.3
     pip install requests==2.31.0
     ```

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

### Speech end detection

If the first sentence is transcribed before you get to the second one, raise post_speech_silence_duration on AudioToTextRecorder:
    ```
    AudioToTextRecorder(model="tiny.en", language="en", spinner=False, post_speech_silence_duration = 1.5) 
    ```
    
## Contributing

Contributions to enhance or improve the project are warmly welcomed. Feel free to open a pull request with your proposed changes or fixes.

## License

The project is open-sourced under the MIT License. 

## Contact

Kolja Beigel  
- Email: [kolja.beigel@web.de](mailto:kolja.beigel@web.de)  

Feel free to reach out for any queries or support related to this project.
