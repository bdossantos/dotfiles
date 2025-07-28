-- Custom keymaps (additional to LazyVim defaults)
-- LazyVim default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ===================================================================
-- INSERT MODE MAPPINGS
-- ===================================================================

-- Quick escape from insert mode (alternative to default jk)
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- ===================================================================
-- NORMAL MODE MAPPINGS
-- ===================================================================

-- Clear search highlighting (LazyVim has <leader><space>, adding comma variant)
map("n", ",<space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Line number toggling
local function number_toggle()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
  end
end

map(
  "n",
  "<C-n>",
  number_toggle,
  { desc = "Toggle relative/absolute line numbers" }
)

-- ===================================================================
-- GIT INTEGRATION
-- ===================================================================

-- Alternative git command (LazyVim has <leader>gg for lazygit)
map("n", ",t", ":LazyGit<CR>", { desc = "Open LazyGit" })

-- ===================================================================
-- CODE FORMATTING
-- ===================================================================

-- Format current file (alternative to LazyVim's <leader>cf)
map("n", ",s", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format current file" })

-- Toggle auto-format on save
map("n", ",se", function()
  vim.g.autoformat = true
  vim.print("Auto format on save: enabled")
end, { desc = "Enable format on save" })

map("n", ",sd", function()
  vim.g.autoformat = false
  vim.print("Auto format on save: disabled")
end, { desc = "Disable format on save" })

-- ===================================================================
-- DISABLED KEYS (FORCE GOOD HABITS)
-- ===================================================================

-- Disable arrow keys to encourage hjkl usage
local disabled_keys = { "<Up>", "<Down>", "<Left>", "<Right>" }
for _, key in ipairs(disabled_keys) do
  map("i", key, "<Nop>", { desc = "Use hjkl instead" })
  map("n", key, "<Nop>", { desc = "Use hjkl instead" })
  map("v", key, "<Nop>", { desc = "Use hjkl instead" })
end
