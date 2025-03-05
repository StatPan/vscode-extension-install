#!/bin/bash

# Path to the scripts directory, relative to the root directory
scripts_dir="./scripts"

# Array to store all extension IDs
all_extensions=()

# Check if the scripts directory exists
if [[ ! -d "$scripts_dir" ]]; then
  echo "Error: Scripts directory not found at '$scripts_dir'"
  exit 1
fi

# Iterate through all .sh files in the scripts directory
find "$scripts_dir" -maxdepth 1 -name "*.sh" -type f -print0 | while IFS= read -r -d $'\0' script_file; do
  # Skip the current file if it's all.sh
  if [[ "$script_file" == *"/all.sh" ]]; then
    continue
  fi

  echo "Processing script: $script_file"

  # Source the script file to load its variables
  source "$script_file"
  
  # Since the script has been sourced, the 'extensions' array should now be defined.
  # Check if the 'extensions' array is not empty, and if so, add its elements to the all_extensions array.
  if [[ -n "${extensions[*]}" ]]; then
      all_extensions+=("${extensions[@]}")
  fi

  # Unset the 'extensions' array for the next script's execution
  unset extensions
done

# Remove duplicate extensions
declare -A unique_extensions
for ext in "${all_extensions[@]}"; do
  unique_extensions["$ext"]=1
done
all_extensions=("${!unique_extensions[@]}")

# Install all extensions
for ext in "${all_extensions[@]}"; do
  echo "Installing extension: $ext"
  code --install-extension "$ext" || { echo "Failed to install extension: $ext"; exit 1; } # Exit the script on installation failure
done

echo "All extensions installation completed."
