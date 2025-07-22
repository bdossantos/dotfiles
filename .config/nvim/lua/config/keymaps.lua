-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Key Bindings from original vimrc
-- jj to escape (already handled by LazyVim by default for jk)
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- Turn off search highlight (also works with space leader)
map(
  "n",
  "<leader><space>",
  ":nohlsearch<CR>",
  { desc = "Clear search highlight" }
)
map("n", ",<space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Unbind the cursor keys in insert, normal and visual modes
local disabled_keys = { "<Up>", "<Down>", "<Left>", "<Right>" }
for _, key in ipairs(disabled_keys) do
  map("i", key, "<Nop>", { desc = "Disabled" })
  map("n", key, "<Nop>", { desc = "Disabled" })
  map("v", key, "<Nop>", { desc = "Disabled" })
end

-- Line number toggle function
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

-- Git integration (LazyVim has <leader>gg for lazygit)
map("n", ",t", ":LazyGit<CR>", { desc = "Open LazyGit" })

-- Format/fix current file (LazyVim has <leader>cf for format)
map("n", ",s", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format current file" })

-- Additional convenience mappings to disable format on save toggle
map("n", ",se", function()
  vim.g.autoformat = true
  vim.print("Auto format on save: enabled")
end, { desc = "Enable format on save" })

map("n", ",sd", function()
  vim.g.autoformat = false
  vim.print("Auto format on save: disabled")
end, { desc = "Disable format on save" })
