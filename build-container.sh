#!/bin/bash
# OutCast build script - nightly/weekly build checks

set -e

echo "=== PHP Lint ==="

# Run lint checks using PHP official Docker image
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php -l index.php
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php -l includes/functions.php
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php -l includes/config.php
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php -l login.php
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php -l register.php
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php -l logout.php
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php -l test_weather.php

echo "=== Quick Weather Test ==="
docker run --rm -v "$PWD":/app -w /app php:8.2-cli php test_weather.php || \
echo "Note: test may fail without a valid API key."

