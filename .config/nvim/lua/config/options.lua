-- Additional options beyond LazyVim defaults
-- LazyVim default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- ===================================================================
-- EDITOR BEHAVIOR
-- ===================================================================

-- Indentation and tabs (2 spaces preferred for most files)
opt.tabstop = 2 -- Visual width of tab character
opt.shiftwidth = 2 -- Number of spaces for auto-indent

-- Search behavior
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ...unless query contains uppercase

-- Folding
opt.foldenable = true -- Enable folding
opt.foldlevelstart = 10 -- Open most folds by default
opt.foldmethod = "indent" -- Fold based on indent level
opt.foldnestmax = 10 -- Maximum 10 nested folds

-- ===================================================================
-- UI AND APPEARANCE
-- ===================================================================

-- Line numbers and visual cues
opt.numberwidth = 5 -- Width of line number column
opt.colorcolumn = "80" -- Show vertical line at 80 characters

-- GUI font (for GUI versions of Neovim)
opt.guifont = "JetBrains Mono:h14"

-- Background (dark theme preference)
opt.background = "dark"

-- ===================================================================
-- FILE HANDLING
-- ===================================================================

-- Swap file locations (avoid cluttering working directory)
-- The '//' ensures unique filenames using full path
opt.directory = vim.fn.expand("~/.vimswap//")
  .. ","
  .. vim.fn.expand("/var/tmp//")
  .. ","
  .. vim.fn.expand("/tmp//")
  .. ",."

-- Disable modelines for security (prevents malicious code in files)
opt.modelines = 0
opt.modeline = false

-- ===================================================================
-- SYSTEM INTEGRATION
-- ===================================================================

-- macOS clipboard integration
opt.clipboard = "unnamed"

-- Terminal title (only for compatible terminals)
if vim.env.TERM == "screen" or vim.env.TERM == "xterm" then
  opt.title = true
end
