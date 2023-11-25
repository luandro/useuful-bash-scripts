#!/bin/bash

# Function to prompt for alias name if not provided as an argument
prompt_for_alias_name() {
  read -p "Enter the alias name: " alias_name
  echo $alias_name
}

# Function to prompt for alias command if not provided as an argument
prompt_for_alias_command() {
  read -p "Enter the alias command: " alias_command
  echo $alias_command
}

# Check if both arguments are provided
if [ ! -z "$1" ] && [ ! -z "$2" ]; then
  alias_name=$1
  alias_command=$2
# Check if only one argument is provided and it's in the format alias-name=alias-command
elif [ ! -z "$1" ] && [[ "$1" =~ ^[a-zA-Z0-9_-]+=.+$ ]]; then
  IFS='=' read -r alias_name alias_command <<< "$1"
# If no arguments or incorrect format, prompt for alias name and command
else
  if [ -z "$1" ] || ! [[ "$1" =~ ^[a-zA-Z0-9_-]+=.+$ ]]; then
    alias_name=$(prompt_for_alias_name)
  fi
  if [ -z "$alias_command" ]; then
    alias_command=$(prompt_for_alias_command)
  fi
fi

# Escape single quotes and substitute them with double quotes in the alias command
alias_command="${alias_command//\'/\"}"

# Create the alias and append it within the alias section in ~/.zshrc
sed -i "/# END_ALIAS_SECTION/i alias $alias_name='$alias_command'" ~/.zshrc

# Check if the current shell is Zsh before sourcing the ~/.zshrc file
if [ -n "$ZSH_VERSION" ]; then
    # Source the ~/.zshrc file to make the alias available immediately
    source ~/.zshrc
else
    echo "Please run 'source ~/.zshrc' to make the alias available immediately."
fi

# Move the function definition to the top, before it's called
