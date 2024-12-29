# Project "Complier festival for Ubuntu 18.04"


## Description
> This project is created to compile the application using gcc.

"Festival" — refers to the text-to-speech (TTS) system integrated into the Festival Speech Synthesis System. Festival is a widely-used framework for speech synthesis developed by the University of Edinburgh. It allows users to convert written text into spoken audio and provides a platform for developing and customizing voices.


Requirements:
-------------------------

- Ubuntu 18.04 or lower
- G++/GCC 4.8.x or lower
- make GNU
- git ( [festival](https://github.com/festvox/festival), [speech_tools](https://github.com/festvox/speech_tools) )

-------------------------


## Installation 

To install and run the project locally, follow these steps:

1. Install dependencies:
   ```bash
   sudo apt-get install gcc gcc-4.8 g++-4.8 make libncurses-dev git

2. Clone the repository:
   ```bash
   git clone https://github.com/festvox/festival
   
   git clone https://github.com/festvox/speech_tools
   
4. Update version gcc:
   ```bash
   sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
   # Update version for C with priority 50.
   sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50
   # Update version for CC with priority 50.

5. Go to folder speech_tools:
   ```bash
   cd speech_tools

6. Start configure:
   ```bash
   ./configure CXXFLAGS="-fPIC" CFLAGS="-fPIC"
   # Checks for the availability of necessary libraries and tools (e.g., compilers). Specifies that all C and C++ files should be compiled with the -fPIC flag. Creates position-independent code needed to build dynamic libraries.

 ![Succesful configure](https://github.com/ivan19911502/pet_project/blob/festival/png/making%20speech%20tools.png)

8. Making speech_tools:
   ```bash
   ~/speech_tools$ make
    # Controls the execution of commands for compilation and assembly using a configuration file, usually called a Makefile.

![Succesful make](https://github.com/ivan19911502/pet_project/blob/festival/png/making%20speech%20tools.png)


10. Go to folder festival:
    ```bash
    cd festival

11. Making festival:
    ```bash
    ~/festival$ make
   
   ![Succesful make](https://github.com/ivan19911502/pet_project/blob/festival/png/making%20festival.png)

11. Copy binary files:
    ```bash
    sudo cp -r bin/* /usr/local/bin/
    sudo cp -r lib/* /usr/local/lib/

   ![Finish](https://github.com/ivan19911502/pet_project/blob/festival/png/finish.png)


