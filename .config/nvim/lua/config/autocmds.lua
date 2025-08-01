-- Custom autocommands (additional to LazyVim defaults)
-- LazyVim default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ===================================================================
-- GENERAL EDITOR BEHAVIOR
-- ===================================================================

local vimrcEx = augroup("vimrcEx", { clear = true })

-- Jump to last cursor position when reopening files
autocmd("BufReadPost", {
  group = vimrcEx,
  pattern = "*",
  callback = function()
    if
      vim.bo.filetype ~= "gitcommit"
      and vim.fn.line("'\"") > 0
      and vim.fn.line("'\"") <= vim.fn.line("$")
    then
      vim.cmd('normal g`"')
    end
  end,
  desc = "Jump to last known cursor position",
})

-- ===================================================================
-- LINE NUMBER BEHAVIOR
-- ===================================================================

-- Switch to absolute line numbers in insert mode for easier navigation
autocmd("InsertEnter", {
  group = vimrcEx,
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = false
  end,
  desc = "Use absolute line numbers in insert mode",
})

-- Switch back to relative line numbers in normal mode
autocmd("InsertLeave", {
  group = vimrcEx,
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = true
  end,
  desc = "Use relative line numbers in normal mode",
})

-- ===================================================================
-- FILETYPE-SPECIFIC SETTINGS
-- ===================================================================

-- Python: Use 4-space indentation following PEP 8
autocmd("FileType", {
  group = vimrcEx,
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 8 -- Tab width for display
    vim.opt_local.expandtab = true -- Use spaces instead of tabs
    vim.opt_local.shiftwidth = 4 -- Indentation level
    vim.opt_local.softtabstop = 4 -- Soft tab width
  end,
  desc = "Python PEP 8 indentation settings",
})

-- Git commit: Enable spellcheck and set text width
autocmd("FileType", {
  group = vimrcEx,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
    vim.opt_local.complete:append("kspell")
  end,
  desc = "Git commit settings: spellcheck and line width",
})

-- Markdown: Enable spellcheck and set filetype
autocmd({ "BufRead", "BufNewFile" }, {
  group = vimrcEx,
  pattern = "*.md",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
  desc = "Set markdown filetype for .md files",
})

autocmd("FileType", {
  group = vimrcEx,
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.complete:append("kspell")
  end,
  desc = "Enable spellchecking for Markdown files",
})

-- Crontab: Disable backup files (required for crontab editing)
autocmd("FileType", {
  group = vimrcEx,
  pattern = "crontab",
  callback = function()
    vim.opt_local.backup = false
    vim.opt_local.writebackup = false
  end,
  desc = "Disable backups for crontab editing",
})

-- ===================================================================
-- TIME-BASED THEME SWITCHING
-- ===================================================================

-- Auto-switch colorscheme based on time of day
local function switch_theme_by_time()
  -- Function to get time-based colorscheme
  local function get_time_based_colorscheme()
    -- Try to use our theme-mode script if available
    local theme_mode_paths = {
      vim.fn.expand("~/.dotfiles/bin/theme-mode"),
      vim.fn.expand("~/.config/nvim/../../bin/theme-mode"),
    }
    
    for _, path in ipairs(theme_mode_paths) do
      if vim.fn.executable(path) == 1 then
        local handle = io.popen(path .. " 2>/dev/null")
        if handle then
          local mode = handle:read("*a"):gsub("%s+", "")
          handle:close()
          
          if mode == "light" then
            return "github_light"
          else
            return "dracula"
          end
        end
      end
    end
    
    -- Fallback: use system time directly
    local hour = tonumber(os.date("%H"))
    if hour >= 7 and hour < 19 then
      return "github_light"
    else
      return "dracula"
    end
  end

  local new_colorscheme = get_time_based_colorscheme()
  if vim.g.colors_name ~= new_colorscheme then
    vim.cmd.colorscheme(new_colorscheme)
  end
end

-- Create augroup for theme switching
local themeGroup = augroup("TimeBasedTheme", { clear = true })

-- Switch theme on entering Neovim
autocmd("VimEnter", {
  group = themeGroup,
  callback = switch_theme_by_time,
  desc = "Switch colorscheme based on time when entering Neovim",
})

-- Optionally switch theme periodically (every 30 minutes)
-- Uncomment the following to enable periodic theme switching:
-- local theme_timer = vim.loop.new_timer()
-- theme_timer:start(0, 30 * 60 * 1000, vim.schedule_wrap(switch_theme_by_time))
