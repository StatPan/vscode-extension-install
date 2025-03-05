#!/bin/bash

# extension ID for vscode
extensions=(
#html
  sidthesloth.html5-boilerplate
  ecmel.vscode-html-css
  Zignd.html-css-class-completion
#css
  ecmel.vscode-html-css
  bradlc.vscode-tailwindcss
#js
  xabikos.JavaScriptSnippets
  ms-vscode.vscode-typescript-next
  ms-vscode.js-debug-nightly
#ts
  yoavbls.pretty-ts-errors
  pmneo.tsimporter
  stringham.move-ts
#node
  jasonnutter.search-node-modules
  dbaeumer.vscode-eslint
  christian-kohler.npm-intellisense
  pflannery.vscode-versionlens
#etc
  esbenp.prettier-vscode
  christian-kohler.path-intellisense

  # ... add extension id 
)

# install extensions
for ext in "${extensions[@]}"; do
  code --install-extension "$ext"
done

echo "extension install completed"