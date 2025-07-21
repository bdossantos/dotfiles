-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Replicate autocmds from original vimrc
local vimrcEx = augroup("vimrcEx", { clear = true })

-- When editing a file, always jump to the last known cursor position
autocmd("BufReadPost", {
  group = vimrcEx,
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "gitcommit" and vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal g`\"")
    end
  end,
  desc = "Jump to last known cursor position"
})

-- Python specific settings
autocmd("FileType", {
  group = vimrcEx,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "Python-specific indentation settings"
})

-- Git commit settings
autocmd("FileType", {
  group = vimrcEx,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
    vim.opt_local.complete:append("kspell")
  end,
  desc = "Git commit settings"
})

-- Markdown settings
autocmd({ "BufRead", "BufNewFile" }, {
  group = vimrcEx,
  pattern = "*.md",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
  desc = "Set markdown filetype"
})

autocmd("FileType", {
  group = vimrcEx,
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.complete:append("kspell")
  end,
  desc = "Enable spellchecking for Markdown"
})

-- Crontab settings
autocmd("FileType", {
  group = vimrcEx,
  pattern = "crontab",
  callback = function()
    vim.opt_local.backup = false
    vim.opt_local.writebackup = false
  end,
  desc = "Crontab settings"
})

-- Line number behavior in insert mode
autocmd("InsertEnter", {
  group = vimrcEx,
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = false
  end,
  desc = "Use absolute line numbers in insert mode"
})

autocmd("InsertLeave", {
  group = vimrcEx,
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = true
  end,
  desc = "Use relative line numbers in normal mode"
})
