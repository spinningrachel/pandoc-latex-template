# Introduction

Welcome to your documentation project. This template system compiles modular markdown chapters into professionally formatted PDFs using Pandoc and LaTeX.

## What You Get

This system provides:

- **Modular chapters** -- each chapter is a separate markdown file
- **Professional PDF output** -- LaTeX-quality formatting with custom title page
- **Section dividers** -- full-page section breaks with automatic numbering
- **Admonitions** -- styled Note, Important, Warning, Tip, and Critical boxes
- **Advanced tables** -- LaTeX tables with alternating row colors and precise column control
- **Reusable snippets** -- shared content included across multiple documents via `!include`
- **Multiple guides** -- build separate documents from the same project

## How It Works

1. Write your content in markdown files under `markdown/`
2. List your chapters in order in `config/chapters.txt`
3. Run `./scripts/build.sh` to generate a PDF

The build system reads the chapter order from the config file, validates all files exist, and compiles them into a single PDF with consistent styling.
