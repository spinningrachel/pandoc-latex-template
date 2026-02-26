#!/bin/bash

# HTML Preview Build Script
# Generates a browser-viewable HTML version for quick iteration

set -e

cd "$(dirname "$0")/.." || exit 1

export PATH="/opt/homebrew/bin:/Library/TeX/texbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

CONFIG_FILE="${1:-config/chapters.txt}"

echo -e "${BLUE}Generating HTML preview...${NC}"

if ! command -v pandoc &> /dev/null; then
    echo -e "${RED}Error: Pandoc is not installed.${NC}"
    exit 1
fi

mkdir -p output

# Read chapter order from config
CHAPTERS=()
while IFS= read -r line; do
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue
    CHAPTERS+=("$line")
done < "$CONFIG_FILE"

# Verify all chapter files exist
for chapter in "${CHAPTERS[@]}"; do
    if [ ! -f "$chapter" ]; then
        echo -e "${RED}Error: Chapter file not found: $chapter${NC}"
        exit 1
    fi
done

# Build HTML
pandoc \
    "${CHAPTERS[@]}" \
    -o output/preview.html \
    --standalone \
    --toc \
    --css=templates/style.css \
    --lua-filter=filters/include-files.lua \
    2>&1

echo -e "${GREEN}✓ Preview generated: output/preview.html${NC}"

# Auto-open in browser (macOS)
if command -v open &> /dev/null; then
    open output/preview.html
fi
