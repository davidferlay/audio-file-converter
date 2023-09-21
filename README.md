# audio-file-converter

- Cross platform script to convert sample rate and bit depth of all supported audio files found recursively

![image](https://github.com/davidferlay/audio-file-converter/assets/20738264/fd1b80b8-b801-4dd1-a26a-df8899e947d5)

## What does it do

Executing the script will:
- Get the list of supported file format from your sox install
- List all files recursively and compare their extensions againt those supported
- Check the sample rate of these files only
- Convert and overwritte in-place those not matching to 44.1 kHz and 24bit
- Output everything in shell for you to check results

## Requirements

- [Install sox](https://madskjeldgaard.dk/posts/sox-tutorial-cli-tape-music/) for your platform
- On Windows you will have to install sox on WSL Ubuntu

## How to use

- Place .sh file at the root directory where all the audio files you want to check and convert reside
   - it can be the AUDIO directory of your Octatrack CF Card, for instance
- Double click on the script to convert all files found as needed
- To execute the script on Windows (through WSL), copy the .cmd file next to the script and click the .cmd to execute exerything

## Default variables

- By defaults, script will check and convert audio files to 44.1 kHz and 24bit
- You can edit these values to your needs in the first line of the script:

![image](https://github.com/davidferlay/audio-file-converter/assets/20738264/17594db8-44b8-4b1e-9792-e78107d0c26f)
