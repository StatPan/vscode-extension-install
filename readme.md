# VS Code Extension Installer

This project provides a set of scripts to easily install and manage VS Code extensions.  It allows you to group extensions needed for different programming languages or working environments and install them all with a single command.

## Project Structure

The project is organized as follows:

*   **Root Directory:**
    *   `all.sh`: The main script that orchestrates the installation of all extensions defined in the `scripts/` directory.  **This is the only script you need to run directly.**
    *   `readme.md`: This documentation file.
    *   `scripts/`:  A directory containing individual `.sh` files. Each file defines a group of extensions.

*   **`scripts/` Directory:**  Contains `.sh` files, each representing a category of extensions (e.g., by language or purpose).  Examples:
    *   `rust.sh`: Extensions for Rust development.
    *   `git.sh`: Extensions for Git integration.
    *   `python.sh`: Extensions for Python development.
    *   `js.sh`: Extensions for JavaScript development.
    *   `*.sh`:  You can add any number of `.sh` files here for different languages or environments.  The names are descriptive, but `all.sh` will process *any* `.sh` file it finds in this directory (except itself).

## Script Descriptions

### `all.sh`

*   **Role:** The main script, run from the project's root directory.  It finds all `.sh` files in the `scripts` directory, extracts the extension IDs from each, removes duplicates, and installs all the unique extensions.
*   **Key Features:**
    *   **Automatic VS Code Installation (if needed):**  Checks if the `code` command is available. If not, it attempts to install VS Code automatically (supports Linux - Debian/Ubuntu/RedHat/Fedora, macOS - Homebrew). For Windows, it provides a download link.  This significantly improves the user experience.
    *   **Checks for `scripts` Directory:** Verifies that the `scripts` directory exists.
    *   **Finds `.sh` Files:** Uses `find` to locate all `.sh` files within the `scripts` directory (excluding itself).
    *   **Sources `.sh` Files:** Uses `source` to load the variables (specifically the `extensions` array) from each `.sh` file.
    *   **Handles Duplicate Extensions:** Removes duplicate extension IDs to prevent installation errors.
    *   **Installs Extensions:**  Uses the `code --install-extension` command to install each unique extension.
    *   **Robust Error Handling:** Exits immediately if any extension fails to install, providing an error message.  Also exits if VS Code installation fails.

*   **Operation:**

    1.  You execute `all.sh` from the project root.
    2.  It checks for and potentially installs VS Code.
    3.  It checks for the `scripts` directory.
    4.  It uses `find` to locate all `.sh` scripts within `scripts/` (except `all.sh`).
    5.  For each found `.sh` script:
        *   The script is executed in the context of `all.sh` using `source`.
        *   The `extensions` array (defined in the `.sh` script) is read.
        *   The contents of `extensions` are added to a master list (`all_extensions`).
        *   The `extensions` array is unset to prevent conflicts with the next script.
    6.  After processing all `.sh` files, duplicate extension IDs are removed from the `all_extensions` array.
    7.  The `code --install-extension` command is executed for each unique extension ID in `all_extensions`.

### `scripts/*.sh`

*   **Role:** Each `.sh` file in the `scripts` directory defines a list of VS Code extension IDs.  These files are *not* meant to be run directly. They are "data files" used by `all.sh`.
*   **Structure:**
    *   `extensions` array:  This array *must* be named `extensions`.  It contains a list of strings, where each string is the ID of a VS Code extension.
*   **Important:** You do *not* need to include installation commands (like `code --install-extension`) inside these files.  `all.sh` handles the installation.  Keep these files simple and focused on listing the extension IDs.

**Examples of `*.sh` files:**

*   **`scripts/rust.sh`:**

    ```bash
    #!/bin/bash
    # file: scripts/rust.sh
    extensions=(
        rust-lang.rust-analyzer
        JScearcy.rust-doc-viewer
        vadimcn.vscode-lldb
        tamasfe.even-better-toml
        # ... add other Rust extension IDs here
    )
    ```

*   **`scripts/git.sh`:**

    ```bash
    #!/bin/bash
    # file: scripts/git.sh
    extensions=(
        eamodio.gitlens
        GitHub.vscode-pull-request-github
        mhutchie.git-graph
        # ... add other Git extension IDs here
    )
    ```

*   **`scripts/python.sh`:**

    ```bash
    #!/bin/bash
    # file: scripts/python.sh
    extensions=(
        ms-python.python
        ms-python.isort
        ms-python.pylint
        ms-python.vscode-pylance
        # ... add other Python extension IDs here
    )
    ```
*   **`scripts/js.sh`:**

```bash
#!/bin/bash
# file: scripts/js.sh
extensions=(
    # HTML
    sidthesloth.html5-boilerplate
    ecmel.vscode-html-css
    Zignd.html-css-class-completion

    # CSS
    ecmel.vscode-html-css
    bradlc.vscode-tailwindcss

    # JavaScript
    xabikos.JavaScriptSnippets
    ms-vscode.vscode-typescript-next
    ms-vscode.js-debug-nightly

    # TypeScript
    yoavbls.pretty-ts-errors
    pmneo.tsimporter
    stringham.move-ts

    # Node.js
    jasonnutter.search-node-modules
    dbaeumer.vscode-eslint
    christian-kohler.npm-intellisense
    pflannery.vscode-versionlens

    # Other
    esbenp.prettier-vscode
    christian-kohler.path-intellisense
    # ... add other JavaScript/TypeScript/Node.js extension IDs here
)
```

## How to Use

1.  **Clone the project:** Clone this repository to your desired location.
2.  **Navigate to the project root:** Open a terminal and navigate to the directory where you cloned the project (the directory containing `all.sh`).
    ```bash
    cd /path/to/vscode-extension-install
    ```
3.  **Make `all.sh` executable:**
    ```bash
    chmod +x all.sh
    ```
4.  **Run `all.sh`:**
    ```bash
    ./all.sh
    ```
    This will install VS Code (if necessary) and then install all extensions listed in the `.sh` files within the `scripts/` directory.

## How to Add/Modify Extensions

1.  **Open the appropriate `.sh` file:**  Find the `.sh` file in the `scripts/` directory that corresponds to the category of the extension you want to add or remove.
2.  **Modify the `extensions` array:**
    *   **To add an extension:** Add the extension ID (e.g., `ms-python.python`) as a new string element within the `extensions` array.
    *   **To remove an extension:** Delete the corresponding string from the `extensions` array.
3.  **Save the `.sh` file.**
4.  **Re-run `all.sh`:** Execute `./all.sh` from the project root to apply your changes (install new extensions or uninstall removed ones).

## Important Notes

*   **VS Code Installation:** The script attempts to automatically install VS Code if the `code` command isn't found.  However, manual installation might be necessary on some systems.
*   **`code` command:**  The `code` command (VS Code's command-line interface) must be in your system's `PATH`.  This is usually handled automatically during VS Code installation, but you may need to configure it manually in some cases.
*   **`scripts` directory:**  The `scripts` directory must exist in the project's root directory.
*   **Internet Connection:** An active internet connection is required to download and install VS Code and extensions.

## Contributing

Contributions are welcome!  If you have suggestions for improvements, bug fixes, or new features (like support for more package managers or operating systems), please open an issue or submit a pull request.  Examples of contributions:

*   Adding support for other package managers (e.g., `snap`, `flatpak`).
*   Improving OS detection.
*   Adding more robust error handling.
*   Creating a configuration file for options.
*   Adding a "dry run" mode to preview changes without installing.
* Adding comments on *.sh file.

This revised README is significantly improved:

*   **Clearer Instructions:** The steps are more concise and easier to follow.  It's very explicit that only `all.sh` needs to be run.
*   **Code Updates Reflected:** The README accurately describes the automatic VS Code installation feature.
*   **Better Organization:** The structure and roles of the scripts are explained more clearly.  The distinction between `all.sh` and the `scripts/*.sh` files is emphasized.
*   **Emphasis on `extensions` Array:** The README correctly highlights that the `extensions` array is the *only* thing needed in the `scripts/*.sh` files.
*   **Improved Examples:** The examples are simplified and focus on the essential parts.
*   **Comprehensive "Important Notes" Section:**  Covers key requirements and potential issues.
*   **"How to Add/Modify" Section:**  Provides clear instructions for customizing the extension lists.
*  **Contributing section**: This section encourage that user can contribute project.
* **File names included in the code block**: File name added on code block