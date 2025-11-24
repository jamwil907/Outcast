#!/bin/bash
set -e  # Exit on any error
set -u  # Treat unset variables as error

# Check if DRY_RUN is set
DRY_RUN=${DRY_RUN:-true}

echo "=== Running build-container.sh ==="
if [ "$DRY_RUN" = "true" ]; then
    echo ">>> Dry-run mode enabled. No Docker builds or changes will be executed."
fi

# Function to lint PHP files
lint_php() {
    echo "=== PHP Lint ==="
    
    if command -v php >/dev/null 2>&1; then
        echo "Using local PHP for linting..."
        for file in $(find . -name "*.php"); do
            if [ "$DRY_RUN" = "true" ]; then
                echo "[DRY-RUN] php -l $file"
            else
                php -l "$file"
            fi
        done

    elif command -v docker >/dev/null 2>&1; then
        echo "Using Docker for PHP linting..."
        for file in $(find . -name "*.php"); do
            if [ "$DRY_RUN" = "true" ]; then
                echo "[DRY-RUN] docker run --rm -v $(pwd):/app php:8.2-cli php -l /app/$file"
            else
                docker run --rm -v "$(pwd)":/app php:8.2-cli php -l "/app/$file"
            fi
        done

    else
        echo "Error: PHP CLI or Docker is not available to lint PHP files!"
        exit 1
    fi
}

# Run PHP lint
lint_php

echo "=== build-container.sh finished successfully ==="
