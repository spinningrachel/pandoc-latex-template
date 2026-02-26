-- Simple include filter for Pandoc
-- Processes !include directives in markdown files
-- Usage in markdown: !include path/to/file.md

function CodeBlock(elem)
  -- Check if this is an include directive
  local include_path = elem.text:match("^!include%s+(.+)$")

  if include_path then
    -- Read the file content
    local file = io.open(include_path, "r")
    if file then
      local content = file:read("*all")
      file:close()

      -- Parse the content as markdown and return it
      local doc = pandoc.read(content, "markdown")
      return doc.blocks
    else
      -- If file not found, return error message
      return pandoc.Para({pandoc.Strong({pandoc.Str("[ERROR: Could not include file: " .. include_path .. "]")})})
    end
  end
end

-- Also handle when it appears as a paragraph
function Para(elem)
  -- Convert entire paragraph to string to handle multi-element content
  local text = pandoc.utils.stringify(elem)
  local include_path = text:match("^!include%s+(.+)$")

  if include_path then
    -- Read the file content
    local file = io.open(include_path, "r")
    if file then
      local content = file:read("*all")
      file:close()

      -- Parse the content as markdown and return it
      local doc = pandoc.read(content, "markdown")
      return doc.blocks
    else
      -- If file not found, return error message
      return pandoc.Para({pandoc.Strong({pandoc.Str("[ERROR: Could not include file: " .. include_path .. "]")})})
    end
  end
end
