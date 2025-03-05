#!/bin/bash

# extension ID for vscode
extensions=(
  eamodio.gitlens
  GitHub.vscode-pull-request-github
  mhutchie.git-graph
  ms-vscode.remote-repositories
  ms-vscode.vscode-github-issue-notebooks
  donjayamanne.githistory
  GitHub.vscode-github-actions
  # ... add extension id 
)

# install extensions
for ext in "${extensions[@]}"; do
  code --install-extension "$ext"
done

echo "extension install completed"