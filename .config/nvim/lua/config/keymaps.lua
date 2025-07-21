-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Key Bindings from original vimrc
-- jj to escape (already handled by LazyVim by default for jk)
map("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- Turn off search highlight
map("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Ag/grep search (will be handled by telescope)
map("n", "<Leader>a", ":Telescope live_grep<CR>", { desc = "Live grep with Telescope" })

-- Open file finder (handled by telescope)
map("n", "<leader>f", ":Telescope find_files<CR>", { desc = "Find files with Telescope" })

-- Easier split navigations (LazyVim already has these but keeping for consistency)
map("n", "<C-J>", "<C-W><C-J>", { desc = "Move to window below" })
map("n", "<C-K>", "<C-W><C-K>", { desc = "Move to window above" })
map("n", "<C-L>", "<C-W><C-L>", { desc = "Move to window right" })
map("n", "<C-H>", "<C-W><C-H>", { desc = "Move to window left" })

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

map("n", "<C-n>", number_toggle, { desc = "Toggle relative/absolute line numbers" })

-- Git integration (will be handled by lazygit)
map("n", "<leader>t", ":LazyGit<CR>", { desc = "Open LazyGit" })

-- Format/fix current file (will be handled by conform.nvim)
map("n", "<leader>s", function() 
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format current file" })