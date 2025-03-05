#!/bin/bash

# extension ID for vscode
extensions=(
  "ms-python.python"
  "ms-python.isort"
  "ms-python.pylint"
  "ms-python.vscode-pylance"
  "ms-python.debugpy"
  "ms-toolsai.jupyter"
  "njpwerner.autodocstring"
  "mgesbert.python-path"
  "njqdev.vscode-python-typehint"
  # ... add extension id 
)

# install extensions
for ext in "${extensions[@]}"; do
  code --install-extension "$ext"
done

echo "extension install completed"