# Useful Daily Usage Scripts

This repository contains a collection of scripts designed to simplify and automate daily tasks. Below is a description of the currently available scripts and a TODO list for future enhancements.

## Scripts

### OCR (Optical Character Recognition)
- **Script Name:** `ocr`
- **Description:** This script takes an image file as input and extracts text from it using optical character recognition technology.
- **Usage:** `./bin/ocr.sh <pdf_file>`

### Create Alias
- **Script Name:** `create-alias`
- **Description:** This script adds new aliases to your zshrc file, making it easier to run commands or set of commands using shortcuts.
- **Usage:** `./create-alias <alias_name> <command>`

## TODO List

### OCR Script
- [ ] Add support for multiple image formats.
- [ ] Implement error handling for unreadable files or unsupported formats.
- [ ] Include an option to specify the output file for the extracted text.

### Create Alias Script
- [ ] Detect the user's default shell and support adding aliases to the appropriate configuration file (e.g., .bashrc, .zshrc).
- [ ] Validate that the alias does not already exist before adding it.
- [ ] Provide feedback to the user if the alias was successfully added or if an error occurred.

Feel free to contribute to this repository by adding more scripts or enhancing the existing ones.
