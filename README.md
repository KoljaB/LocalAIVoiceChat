# Local AI Voice Chat 

Provides talk in realtime with AI, completely local on your PC, with customizable AI personality and voice.

> **Hint:** *Anybody interested in state-of-the-art voice solutions please also <strong>have a look at [Linguflex](https://github.com/KoljaB/Linguflex)</strong>. It lets you control your environment by speaking and is one of the most capable and sophisticated open-source assistants currently available.*

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

- Update to Coqui XTTS 2.0 model
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

2. Install llama.cpp
    - Official way:
     ```python
     pip install llama-cpp-python --force-reinstall --upgrade --no-cache-dir --verbose
     ```

    - If the official installation does not work for you, please install [text-generation-webui](https://github.com/oobabooga/text-generation-webui), which provides some excellent wheels for a lot of platforms and environments

3. Install realtime libraries
   - Install the main libraries:
     ```python
     pip install RealtimeSTT==0.1.7
     pip install RealtimeTTS==0.2.7
     ```
4. Download zephyr-7b-beta.Q5_K_M.gguf from [here](https://huggingface.co/TheBloke/zephyr-7B-beta-GGUF/tree/main). 
   - Open creation_params.json and enter the filepath to the downloaded model into `model_path`.
   - Adjust n_gpu_layers (0-35, raise if you have more VRAM) and n_threads (number of CPU threads, i recommend not using all available cores but leave some for TTS)

5. If dependency conflicts occur, install specific versions of conflicting libraries:
     ```python
     pip install networkx==2.8.8
     pip install typing_extensions==4.8.0
     pip install fsspec==2023.6.0
     pip install imageio==2.31.6
     pip install numpy==1.24.3
     pip install requests==2.31.0
     ```   

## Running the Application
     python ai_voicetalk_local.py

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

The project is under [Coqui Public Model License 1.0.0](https://coqui.ai/cpml).

This license allows only non-commercial use of a machine learning model and its outputs.


## Contact

Kolja Beigel  
- Email: [kolja.beigel@web.de](mailto:kolja.beigel@web.de)  

Feel free to reach out for any queries or support related to this project.
