#!/bin/bash
set -e  # Exit on any error
set -u  # Treat unset variables as error

echo "=== Running build-container.sh ==="

# Function to lint PHP files
lint_php() {
    echo "=== PHP Lint ==="
    
    if command -v php >/dev/null 2>&1; then
        echo "Using local PHP for linting..."
        for file in $(find . -name "*.php"); do
            php -l "$file"
        done

    elif command -v docker >/dev/null 2>&1; then
        echo "Using Docker for PHP linting..."
        for file in $(find . -name "*.php"); do
            docker run --rm -v "$(pwd)":/app php:8.2-cli php -l "/app/$file"
        done

    else
        echo "Error: PHP CLI or Docker is not available to lint PHP files!"
        exit 1
    fi
}

# Run PHP lint
lint_php

echo "=== build-container.sh finished successfully ==="
