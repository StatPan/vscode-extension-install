#!/bin/bash
# file: scripts/all.sh

# Path to the scripts directory, relative to the root directory
scripts_dir="./scripts"
# Array to store all extension IDs
all_extensions=()

# Check for 'code' command and install VS Code if not found.
if ! command -v code &> /dev/null; then
  echo "'code' command not found.  Attempting to install VS Code..."

  # Detect OS and use appropriate installation method.  This is a simplified example
  # and may need adjustments for specific distributions and package managers.
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Assuming a Debian/Ubuntu based system. Adjust for other distros.
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get install -y software-properties-common apt-transport-https curl
        curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/vscode.gpg > /dev/null
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscode.gpg https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
        sudo apt-get update
        sudo apt-get install -y code
    elif command -v yum &> /dev/null; then  # Example for Red Hat/Fedora/CentOS
      sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
      sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
      sudo yum check-update
      sudo yum install -y code
    elif command -v dnf &> /dev/null; then # Example for Fedora
      sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
      sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
      sudo dnf check-update
      sudo dnf install -y code
    else
       echo "Could not determine package manager.  Please install VS Code manually."
       exit 1
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then  # macOS
    # Using Homebrew (assuming it's installed)
    if command -v brew &> /dev/null; then
      brew install --cask visual-studio-code
    else
      echo "Homebrew not found. Please install VS Code manually or install Homebrew."
      exit 1
    fi

  elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then # Windows (Git Bash / Cygwin)
        echo "VS Code installation on Windows is not automated. Please install from:"
        echo "https://code.visualstudio.com/Download"
        exit 1  # Or provide manual instructions / exit.
  else
    echo "Unsupported operating system: $OSTYPE"
    echo "Please install VS Code manually from: https://code.visualstudio.com/"
    exit 1
  fi

  # Verify installation
  if ! command -v code &> /dev/null; then
    echo "VS Code installation failed."
    exit 1
  fi
fi


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
  unique_extensions["$ext"]=1; } # Exit the script on installation failure
done

echo "All extensions installation completed."
