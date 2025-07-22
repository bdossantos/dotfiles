-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Settings from original vimrc
opt.autoindent = true -- match indentation of previous line
opt.autowrite = true -- Automatically :write before running commands
opt.backspace = { "indent", "eol", "start" } -- backspace through everything in insert mode
opt.clipboard = "unnamed" -- For OSX clipboard
opt.cursorline = true -- Highlight current line
opt.encoding = "utf-8"
opt.expandtab = true -- use spaces, not tabs
opt.foldenable = true -- Enable folding
opt.foldlevelstart = 10 -- Open most folds by default
opt.foldmethod = "indent" -- Fold based on indent level
opt.foldnestmax = 10 -- 10 nested fold max
opt.hidden = true -- Handle multiple buffers better
opt.history = 1000 -- Store lots of :cmdline history
opt.hlsearch = true -- Highlight search results
opt.ignorecase = true -- Ignore case when searching
opt.incsearch = true -- Makes search act like in modern browsers
opt.laststatus = 2 -- Always display the status line
opt.number = true -- Show line numbers
opt.numberwidth = 5 -- Width of the "gutter" column used for numbering
opt.relativenumber = true -- Relative line numbers
opt.ruler = true -- Show cursor position
opt.showcmd = true -- Show command in bottom bar
opt.showmatch = true -- Highlight matching [{()}]
opt.smartcase = true -- When searching try to be smart about cases
opt.smarttab = true
opt.spelllang = "en" -- Check all regions of English
opt.tabstop = 2 -- a tab is two spaces
opt.shiftwidth = 2 -- a tab is two spaces
opt.ttimeout = true -- Fast VIM
opt.ttimeoutlen = 100
opt.undofile = true -- Persistent undo
opt.wildmenu = true -- Enhanced command line completion
opt.wildmode = "list:longest" -- Complete files like a shell
opt.wrap = false -- don't wrap lines

-- Color column
opt.colorcolumn = "80"

-- Update sign column every quarter second
opt.updatetime = 250

-- Disable modelines for security reasons
opt.modelines = 0
opt.modeline = false

-- More natural split opening
opt.splitbelow = true
opt.splitright = true

-- Store swap files in fixed location, not current directory
opt.directory = vim.fn.expand("~/.vimswap//")
  .. ","
  .. vim.fn.expand("/var/tmp//")
  .. ","
  .. vim.fn.expand("/tmp//")
  .. ",."

-- Set guifont for GUI versions
opt.guifont = "JetBrains Mono:h14"

-- Set background and syntax
opt.background = "dark"
vim.cmd("syntax enable")

-- Title settings for terminal
if vim.env.TERM == "screen" or vim.env.TERM == "xterm" then
  opt.title = true
end
