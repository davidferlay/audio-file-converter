#!/bin/bash

# Define main variables
output_bit_depth=24
output_sample_rate=44100

# Function to check the sample rate of an audio file using soxi
get_sample_rate() {
  local input_file="$1"
  soxi -r "$input_file"
}

# Function to convert audio files to 44.1kHz sample rate using sox
convert_audio() {
  local input_file="$1"

  # Compute the temp file name, keeping same extension
  local temp_file="${input_file%.*}_${output_bit_depth}b_${output_sample_rate}.${input_file##*.}"

  # Compute the output file name
  local output_file="${input_file}"

  # Check the sample rate of the input file
  local sample_rate=$(get_sample_rate "$input_file")

  # If the sample rate does not match the one defined, perform the conversion
  if [ -n "$sample_rate" ] && [ "$sample_rate" != "$output_sample_rate" ]; then
    echo "- $input_file: Converting from $sample_rate Hz to $output_sample_rate Hz"
    sox "$input_file" -b $output_bit_depth -r $output_sample_rate "$temp_file" && mv "$temp_file" "$output_file"
  elif [ "$sample_rate" == "$output_sample_rate" ]; then
    echo "- $input_file: Already in $output_sample_rate Hz. Skipping"
  else
    echo "- Error: Unable to determine sample rate for $input_file. Skipping."
  fi
}

# Find and convert audio files recursively
echo "Starting script..."
echo
sox --version
echo
find . -type f \( -iname "*.wav" -o -iname "*.aif" \) | while read -r audio_file; do
  convert_audio "$audio_file"
done
echo
echo "Conversion completed."

# Remove the following line if you don't want the script to sleep indefinitely
sleep infinity
