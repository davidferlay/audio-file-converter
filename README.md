# audio-file-converter

- Cross platform script to convert sampe rate and bit depth of all supported audio files found recursively

## What does it do

- Gets the list of supported file format from sox command line
- Lists all files recursively and compare their file extensions againt those supported
- Checks the sample rate of these files only
- Convert those not matching to 44.1 kHz and 24bit

## Requirements

- [Install sox](https://madskjeldgaard.dk/posts/sox-tutorial-cli-tape-music/) for your platform
- On Windows you will have to install sox on WSL Ubuntu

## How to use

- Place .sh file at the root directory where all audio files you want to check and convert resides
   - it can be the AUDIO directory of your Octatrack CF Card, for instance
- Double click on the script to convert all files found as needed
- To execute the script on Windows (through WSL), copy the .cmd file nest to the script and click the .cmd to execute exerything
use the audio-file-converter.cmd
