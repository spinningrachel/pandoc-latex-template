# Pandoc LaTeX Template

Modular documentation system that compiles markdown chapters into professional PDFs with custom title pages, section dividers, admonitions, and precise LaTeX formatting.

Write in markdown. Get publication-quality PDFs.

## Quick Start

### 1. Install Prerequisites

**macOS:**
```bash
brew install pandoc
brew install basictex

# Install required LaTeX packages
sudo tlmgr update --self
sudo tlmgr install collection-fontsrecommended fancyhdr
```

**Ubuntu/Debian:**
```bash
sudo apt install pandoc texlive-xetex texlive-fonts-recommended
```

You'll also need the [Inter](https://fonts.google.com/specimen/Inter) and [JetBrains Mono](https://www.jetbrains.com/lp/mono/) fonts installed on your system.

### 2. Clone and Build the Sample

```bash
git clone https://github.com/spinningrachel/pandoc-latex-template.git
cd pandoc-latex-template
./scripts/build.sh
```

Open `output/Documentation.pdf` to see the result.

### 3. Make It Yours

**Replace brand assets** in `images/`:
- `brand-background.png` -- title page background (A4 size recommended)
- `logo.png` -- your logo for headers and footers
- `icon-*.png` -- admonition icons (square, ~64px)

**Set your title** in `scripts/build.sh`:
```bash
cat > /tmp/doc-title-defs.tex << 'EOF'
\newcommand{\DocTitle}{My Project}
\newcommand{\DocSubtitle}{User Guide}
EOF
```

**Customize colors** in `templates/header.tex`:
```latex
\definecolor{primarycolor}{RGB}{25, 25, 60}     % Footer background, headers
\definecolor{sectioncolor}{RGB}{48, 26, 76}     % Section dividers
\definecolor{tableprimary}{RGB}{233, 228, 241}  % Table row color 1
\definecolor{tablesecondary}{RGB}{244, 241, 248}% Table row color 2
```

### 4. Add Your Content

Create markdown files in `markdown/guide-1/chapters/` and list them in `config/chapters.txt`:

```
# My Guide
markdown/guide-1/sections/getting-started.md
markdown/guide-1/chapters/introduction.md
markdown/guide-1/chapters/chapter-two.md
```

Then build: `./scripts/build.sh`

## Features

### Section Dividers

Full-page section breaks with automatic numbering (SECTION I, II, III...):

```markdown
\sectiondivider{Getting Started}
```

### Admonitions

Five styled callout types with colored borders and icons:

```markdown
\notestart
This is a note with supplementary information.
\noteend

\warningstart
This is a warning about potential issues.
\warningend
```

Available types: `note`, `important`, `warning`, `tip`, `critical`

### Advanced Tables

**Markdown tables** get automatic alternating row colors. For precise column control, use LaTeX:

```latex
\rowcolors{1}{tableprimary}{tablesecondary}
\begin{tabularx}{\textwidth}{|p{0.3\textwidth}|X|}
\hline
\textbf{Column A} & \textbf{Column B (auto-width)} \\
\hline
Content & More content \\
\hline
\end{tabularx}
```

### Process Instructions

Styled headers for step-by-step procedures:

```markdown
\processstart
To configure the system
\processend

1. First step...
2. Second step...
```

### Reusable Snippets

Share content across multiple documents:

```markdown
!include markdown/snippets/shared-requirements.md
```

### Multiple Guides

Build separate documents from the same project:

```bash
# Build guide 1
./scripts/build.sh config/chapters.txt "User_Guide"

# Build guide 2
./scripts/build.sh config/admin-guide.txt "Admin_Guide"
```

Each guide gets its own config file, chapter set, and output PDF.

## Project Structure

```
your-project/
├── markdown/                    # All markdown content
│   ├── guide-1/                # First guide
│   │   ├── chapters/           # Chapter files (.md)
│   │   └── sections/           # Section divider files
│   └── snippets/               # Reusable content
├── images/                     # Brand assets and icons
├── templates/                  # LaTeX and CSS templates
│   ├── header.tex             # Core LaTeX styling
│   ├── pdf-template.yaml      # PDF configuration (fonts, margins)
│   └── style.css              # HTML preview styling
├── config/                     # Chapter order configs
│   └── chapters.txt           # Chapter order (source of truth)
├── scripts/                    # Build scripts
│   ├── build.sh               # Build PDF
│   └── preview.sh             # HTML preview
├── filters/                    # Pandoc Lua filters
│   └── include-files.lua      # !include directive processor
└── output/                     # Generated files (gitignored)
```

## Customization Reference

| What to change | Where |
|----------------|-------|
| Document title and subtitle | `scripts/build.sh` (title defs) |
| Brand colors | `templates/header.tex` (definecolor) |
| Fonts | `templates/pdf-template.yaml` (mainfont, monofont) |
| Page margins | `templates/pdf-template.yaml` (geometry) |
| Footer background | `templates/header.tex` (primarycolor) |
| Chapter order | `config/chapters.txt` |
| Table row colors | `templates/header.tex` (tableprimary, tablesecondary) |
| Code block width | `templates/header.tex` (Shaded minipage width) |
| Admonition icons | `images/icon-*.png` |

## License

MIT
