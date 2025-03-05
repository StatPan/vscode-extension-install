# VS Code Extension Installer

This project provides a set of scripts to easily install and manage VS Code extensions. It allows you to group extensions needed for different programming languages or working environments, and install them all with a single command.

## Project Structure
need help this part

**Root Directory:**
    *   `all.sh`: The main script to install all extensions.
    *   `readme.md`: Project documentation.
    *   `scripts/`: Directory containing individual `.sh` files for different extension groups.
    *   **`scripts/` Directory:**
    *   `rust.sh`: Extensions for Rust development.
    *   `git.sh`: Extensions for Git integration.
    *   `python.sh`: Extensions for Python development.
    *   `js.sh`: Extensions for JavaScript development.
    *   `*.sh`: Other `.sh` files for different languages or environments.

## Script Descriptions*   


### `all.sh`

*   **Role:** Executed from the root directory, this script runs all `.sh` scripts located in the `scripts` directory. It gathers the extension lists, removes duplicates, and finally installs all the extensions using the `code --install-extension` command.
*   **Key Features:**
    *   Checks for the existence of the `scripts` directory.
    *   Searches for `.sh` files within the `scripts` directory.
    *   Loads variables and executes each `.sh` file via `source`.
    *   Extracts the list of extension IDs defined in the `extensions` array within each `.sh` file.
    *   Removes duplicate extension IDs.
    *   Installs extensions using the `code --install-extension` command.
    *   Outputs an error and exits the script if an installation fails.
* **Operation Method**
    1. `all.sh` is executed.
    2. The `scripts` directory in the root directory is searched.
    3. Each `.sh` script other than `all.sh` is found using the `find` command.
    4. Each `.sh` script is executed with the `source` command.
        * The content of the `.sh` script file is executed in the context of `all.sh`.
        * The `extensions` array in the `.sh` script is defined.
        * Check if there is a value in the `extensions` array, and if there is, add the value to the all_extensions array.
        * The `extensions` array is initialized to remove the influence of the previous script's array value.
    5. After all scripts have been searched, duplicate extensions are removed.
    6. The `code --install-extension` command is executed, iterating through the deduplicated `all_extensions` array to install the extensions.

### `scripts/*.sh`

*   **Role:** Each `.sh` file defines a list of VS Code extension IDs required for a specific language or development environment in an array named `extensions`.
*   **Components:**
    *   `extensions` array: Contains the list of extension IDs to be installed.
    *   `code --install-extension` command: If directly executed in each file, excluding `all.sh`, the extension will be installed. However, since it is sourced in `all.sh`, this code is unnecessary.
    * Each extension list will display the extensions to be added using the comment `(# ... add extension id)`.

**Examples of each `*.sh` file:**

*   **`rust.sh`:**
    ```bash
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
    # for ext in "${extensions[@]}"; do
    #   code --install-extension "$ext"
    # done

    # echo "extension install completed"
    ```

*   **`git.sh`:**
    ```bash
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
    # for ext in "${extensions[@]}"; do
    #   code --install-extension "$ext"
    # done

    # echo "extension install completed"
    ```

*   **`python.sh`:**
    ```bash
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
    # for ext in "${extensions[@]}"; do
    #   code --install-extension "$ext"
    # done

    # echo "extension install completed"
    ```

*   **`js.sh`:**
    ```bash
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
    # for ext in "${extensions[@]}"; do
    #   code --install-extension "$ext"
    # done

    # echo "extension install completed"
    ```

## How to Use

1.  Clone the project to your desired location.
2.  Navigate to the project's root directory (where the `all.sh` file is located) in your terminal.
    ```bash
    cd /path/to/vscode-extension-install
    ```
3.  Grant execute permission to the `all.sh` file.
    ```bash
    chmod +x all.sh
    ```
4.  Run the `all.sh` script.
    ```bash
    ./all.sh
    ```
5.  Once the script runs, it will execute all `.sh` files in the `scripts` directory and install the specified extensions.

## How to Add/Modify Extensions

1.  Open the appropriate `.sh` file in the `scripts` directory for the language or environment you're working with.
2.  Add the ID of the extension you want to install to the `extensions` array.
3.  Save the changes.
4.  Re-run `all.sh` to install the newly added extensions.

## Important Notes

*   VS Code must be installed.
*   The `code` command must be registered in your system's PATH.
*   There must be a scripts folder in the root folder.

## Contributing

This project has plenty of room for improvement. Contributions are welcome!
