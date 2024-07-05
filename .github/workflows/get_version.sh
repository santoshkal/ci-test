#!/bin/bash

# Set the working directory
WORKING_DIR="./dockerfile_policies"

# Navigate to the directory containing the version.env file
cd "$WORKING_DIR" || { echo "Failed to navigate to $WORKING_DIR"; exit 1; }

# Read the VERSION value from version.env
VERSION=$(grep '^VERSION=' version.env | cut -d '=' -f 2)

# Output the VERSION value for debugging
echo "VERSION: $VERSION"

# Set the output for GitHub Actions
echo "::set-output name=new_version::$VERSION"
