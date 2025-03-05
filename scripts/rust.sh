#!/bin/bash

# extension ID for vscode
extensions=(
  rust-lang.rust-analyzer
  JScearcy.rust-doc-viewer
  vadimcn.vscode-lldb
  tamasfe.even-better-toml
  
  # ... add extension id 
)

# install extensions
for ext in "${extensions[@]}"; do
  code --install-extension "$ext"
done

echo "extension install completed"