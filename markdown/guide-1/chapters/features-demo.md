# Features Demo

This chapter demonstrates all the formatting features available in the template.

## Admonitions

Admonitions are styled callout boxes for highlighting important information. Each type has its own color and icon.

\notestart
This is a **Note** admonition. Use it for supplementary information that helps the reader but isn't critical to the task at hand.
\noteend

\importantstart
This is an **Important** admonition. Use it for information the reader must know to avoid problems.
\importantend

\warningstart
This is a **Warning** admonition. Use it for actions that could cause data loss or other serious consequences.
\warningend

\tipstart
This is a **Tip** admonition. Use it for helpful suggestions that improve the reader's workflow.
\tipend

\criticalstart
This is a **Critical** admonition. Use it for information that must not be ignored under any circumstances.
\criticalend

## Tables

### Markdown Tables

Standard markdown tables are automatically styled with alternating row colors:

| **Feature** | **Description** | **Status** |
| :---- | :---- | :---- |
| Modular chapters | Edit each section independently | Available |
| PDF output | Professional LaTeX-quality formatting | Available |
| Section dividers | Full-page section breaks | Available |
| Admonitions | Styled callout boxes (5 types) | Available |
| Reusable snippets | Shared content via !include | Available |

### LaTeX Tables

For precise column control, use LaTeX `tabularx` tables:

\rowcolors{1}{tableprimary}{tablesecondary}
\begin{tabularx}{\textwidth}{|p{0.25\textwidth}|X|p{0.15\textwidth}|}
\hline
\textbf{Column A} & \textbf{Column B (auto-width)} & \textbf{Column C} \\
\hline
First row & This column automatically expands to fill available space & Value 1 \\
\hline
Second row & LaTeX tables give you precise control over column widths & Value 2 \\
\hline
Third row & Alternating row colors are applied automatically & Value 3 \\
\hline
\end{tabularx}

## Code Blocks

Code blocks are styled with a light background and constrained width:

```bash
# Build the PDF
./scripts/build.sh

# Preview in browser
./scripts/preview.sh
```

```json
{
  "name": "example",
  "version": "1.0",
  "features": ["tables", "admonitions", "code-blocks"]
}
```

## Process Instructions

Use process instructions for step-by-step procedures:

\processstart
To build your first PDF
\processend

1. Install the prerequisites (Pandoc and LaTeX).

2. Add your content to markdown files in `markdown/guide-1/chapters/`.

3. List your chapters in `config/chapters.txt`.

4. Run the build script:

```bash
./scripts/build.sh
```

5. Open `output/Documentation.pdf` to see your formatted document.

## Cross-References

Add section IDs to create cross-references:

```markdown
## My Section {#my-section}

See [My Section](#my-section) for details.
```

## Images

Include images with markdown syntax:

```markdown
![Caption text](images/screenshot.png){ width=80% }
```

Use the `width` parameter to control image size as a percentage of text width.

## Reusable Snippets

Include shared content from the snippets directory:

```markdown
!include markdown/snippets/shared-content.md
```

The `!include` directive is processed by the Pandoc Lua filter during build.
