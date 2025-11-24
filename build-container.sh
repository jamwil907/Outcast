#!/bin/bash
# OutCast build script - nightly/weekly build checks

set -e  # Exit immediately if a command exits with a non-zero status

echo "=== PHP Lint ==="

# Check syntax of PHP files
php -l index.php
php -l includes/functions.php
php -l includes/config.php
php -l login.php
php -l register.php
php -l logout.php
php -l test_weather.php

echo "=== Quick Weather Test ==="
# Run a quick weather test; non-zero exit won't fail the script
if ! php test_weather.php; then
    echo "Note: test may fail without a valid API key."
fi

echo "Build checks completed."
