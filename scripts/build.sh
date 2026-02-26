#!/bin/bash

# Documentation Build Script
# Compiles markdown chapters into a professional PDF

# Exit on error
set -e

# Change to project root directory
cd "$(dirname "$0")/.." || exit 1

# Set PATH to include Pandoc and LaTeX locations
export PATH="/opt/homebrew/bin:/Library/TeX/texbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default config file
CONFIG_FILE="${1:-config/chapters.txt}"
OUTPUT_NAME="${2:-Documentation}"

echo -e "${BLUE}Building PDF from ${CONFIG_FILE}...${NC}"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo -e "${RED}Error: Pandoc is not installed.${NC}"
    echo "Please install Pandoc first:"
    echo "  brew install pandoc       # macOS"
    echo "  sudo apt install pandoc   # Ubuntu/Debian"
    exit 1
fi

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}Error: Config file not found: ${CONFIG_FILE}${NC}"
    echo "Create a config file listing your chapter files, one per line."
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p output

# Read chapter order from config file (ignoring comments and empty lines)
CHAPTERS=()
while IFS= read -r line; do
    # Skip comments and empty lines
    [[ "$line" =~ ^#.*$ ]] && continue
    [[ -z "$line" ]] && continue
    CHAPTERS+=("$line")
done < "$CONFIG_FILE"

# Verify all chapter files exist
echo -e "${BLUE}Checking chapter files...${NC}"
for chapter in "${CHAPTERS[@]}"; do
    if [ ! -f "$chapter" ]; then
        echo -e "${RED}Error: Chapter file not found: $chapter${NC}"
        exit 1
    fi
    echo -e "  ✓ $chapter"
done

# Build the PDF
echo -e "${BLUE}Compiling chapters...${NC}"

# Create temporary header with title definitions
# Customize these for your project
cat > /tmp/doc-title-defs.tex << 'EOF'
\newcommand{\DocTitle}{Your Project Name}
\newcommand{\DocSubtitle}{Documentation}
EOF

pandoc \
    "${CHAPTERS[@]}" \
    -o "output/${OUTPUT_NAME}.pdf" \
    --from=markdown-implicit_figures \
    --pdf-engine=xelatex \
    --top-level-division=chapter \
    --metadata-file=templates/pdf-template.yaml \
    --include-in-header=/tmp/doc-title-defs.tex \
    --include-in-header=templates/header.tex \
    --lua-filter=filters/include-files.lua \
    2>&1

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ PDF generated successfully!${NC}"
    echo -e "Output: ${GREEN}output/${OUTPUT_NAME}.pdf${NC}"

    # Show file size
    SIZE=$(du -h "output/${OUTPUT_NAME}.pdf" | cut -f1)
    echo -e "File size: ${SIZE}"

    # Show chapter count
    echo -e "Chapters included: ${#CHAPTERS[@]}"
else
    echo -e "${RED}✗ Build failed${NC}"
    exit 1
fi
