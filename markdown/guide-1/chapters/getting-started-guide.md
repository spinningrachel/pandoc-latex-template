# Getting Started

## Prerequisites

Install the following tools:

| **Tool** | **Purpose** | **Install** |
| :---- | :---- | :---- |
| Pandoc | Document converter | `brew install pandoc` (macOS) or `sudo apt install pandoc` (Ubuntu) |
| XeLaTeX | PDF generation engine | `brew install basictex` (macOS) or `sudo apt install texlive-xetex` (Ubuntu) |
| Inter font | Document body font | Download from [Google Fonts](https://fonts.google.com/specimen/Inter) |
| JetBrains Mono | Code block font | Download from [JetBrains](https://www.jetbrains.com/lp/mono/) |

After installing BasicTeX (macOS), install the required LaTeX packages:

```bash
sudo tlmgr update --self
sudo tlmgr install collection-fontsrecommended fancyhdr
```

## Project Structure

```
your-project/
├── markdown/                    # All markdown content
│   ├── guide-1/                # Your first guide
│   │   ├── chapters/           # Chapter files
│   │   └── sections/           # Section divider files
│   └── snippets/               # Reusable content snippets
├── images/                     # Images and brand assets
│   ├── brand-background.png   # Title page background
│   ├── logo.png               # Your logo
│   └── icon-*.png             # Admonition icons
├── templates/                  # LaTeX and CSS templates
│   ├── header.tex             # All LaTeX styling
│   ├── pdf-template.yaml      # PDF configuration
│   └── style.css              # HTML preview styling
├── config/                     # Chapter order configs
│   └── chapters.txt           # Chapter order (single source of truth)
├── scripts/                    # Build scripts
│   ├── build.sh               # Build PDF
│   └── preview.sh             # Generate HTML preview
├── filters/                    # Pandoc Lua filters
│   └── include-files.lua      # Process !include directives
└── output/                     # Generated files (gitignored)
```

## Creating Your First Guide

### Step 1: Add Your Brand Assets

Replace the placeholder images in the `images/` directory:

- **`brand-background.png`** -- title page background (full A4 size, ~2480x3508px recommended)
- **`logo.png`** -- your logo (displayed in header/footer, keep small)
- **`icon-note.png`**, **`icon-important.png`**, **`icon-warning.png`**, **`icon-tip.png`** -- admonition icons (square, ~64x64px)

### Step 2: Customize Colors and Titles

Edit `templates/header.tex` to change:

- **Colors** -- modify the `\definecolor` lines near the top
- **Default title** -- change the `\providecommand{\DocTitle}` and `\DocSubtitle` lines
- **Header text** -- update the `\fancyhead[L]` line in the `fancy` pagestyle

Edit `scripts/build.sh` to set your document title:

```bash
cat > /tmp/doc-title-defs.tex << 'EOF'
\newcommand{\DocTitle}{My Project}
\newcommand{\DocSubtitle}{User Guide}
EOF
```

### Step 3: Write Content

Create markdown files in `markdown/guide-1/chapters/`. Each file becomes a chapter:

```markdown
# Chapter Title

## Section One

Your content here. Use standard markdown formatting.

## Section Two

More content with **bold**, *italic*, and `code`.
```

### Step 4: Set Chapter Order

Edit `config/chapters.txt` to list your chapters in order:

```
# My Guide Chapter Order
markdown/guide-1/sections/getting-started.md
markdown/guide-1/chapters/introduction.md
markdown/guide-1/chapters/chapter-two.md
markdown/guide-1/chapters/chapter-three.md
```

### Step 5: Build

```bash
./scripts/build.sh
```

Your PDF appears at `output/Documentation.pdf`.

## Adding a Second Guide

To create another guide from the same project:

1. Create a new directory: `markdown/guide-2/chapters/`
2. Create a new config: `config/guide-2.txt`
3. Create a new build script (or pass arguments):

```bash
./scripts/build.sh config/guide-2.txt "My_Second_Guide"
```

## Customization Quick Reference

| **What to change** | **Where** |
| :---- | :---- |
| Document title | `scripts/build.sh` (title defs section) |
| Colors | `templates/header.tex` (definecolor lines) |
| Fonts | `templates/pdf-template.yaml` (mainfont, monofont) |
| Page margins | `templates/pdf-template.yaml` (geometry) |
| Footer background color | `templates/header.tex` (primarycolor) |
| Chapter order | `config/chapters.txt` |
| Code block width | `templates/header.tex` (minipage width in Shaded) |
| Table colors | `templates/header.tex` (tableprimary, tablesecondary) |
