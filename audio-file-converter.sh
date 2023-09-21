#!/bin/bash

# Define main variables
output_bit_depth=24
output_sample_rate=44100

convert_to_kHz() {
  local sample_rate="$1"
  echo "$((sample_rate / 1000)).$((sample_rate % 1000 / 100)) kHz"
}

# Define the supported extensions using the output of the 'sox' command
get_supported_extensions() {
  supported_extensions=$(sox --help | grep -A1 "^AUDIO FILE FORMATS:" | head -1 | sed 's/AUDIO FILE FORMATS: //g' | tr -s ' ' '\n')
  # Make sure it returned somes values
  if [ -z "$supported_extensions" ]; then
  	echo "Error: No supported extensions found using sox command."
  	exit 1
  else echo "Supported extensions: $(echo $supported_extensions | tr -s '\n' ' ')"
  fi
}

# Function to check the sample rate of an audio file using 'soxi'
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
  local input_sample_rate=$(get_sample_rate "$input_file")

  # If the sample rate does not match the one defined, perform the conversion
  if [ -n "$input_sample_rate" ] && [ "$input_sample_rate" != "$output_sample_rate" ]; then
    echo "- Converting from $(convert_to_kHz "$input_sample_rate") to $(convert_to_kHz "$output_sample_rate"): $input_file"
    # The magic happens here
    sox "$input_file" -b $output_bit_depth -r $output_sample_rate "$temp_file" && mv "$temp_file" "$output_file"
  elif [ "$input_sample_rate" == "$output_sample_rate" ]; then
    echo "- Already in $(convert_to_kHz "$output_sample_rate"): $input_file - Skipping"
  else
    echo "- Warning: Unable to determine sample rate for $input_file. Skipping."
  fi
}

# Find and convert audio files recursively
echo "Starting script..."
echo
sox --version
get_supported_extensions
echo

# List files recursively from the current directory
find . -type f | while read -r file; do
  # Get the file extension of the current file
  file_extension=$(echo "$file" | awk -F. '{print $NF}')
  
  # Check if the file extension matches one of the supported extensions
  if echo "$supported_extensions" | grep -qw "$file_extension"; then
  	# If yes, convert file
    convert_audio "$file"
  else
    echo "- Unsupported file extension: $file"
  fi
done

echo
echo "Conversion completed."

# Prevent shell windo to close, to check logs
sleep infinity
