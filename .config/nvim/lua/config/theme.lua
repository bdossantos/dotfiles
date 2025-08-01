-- Dynamic Theme Configuration
-- This file is managed by theme-switcher script

local M = {}

-- Theme detection function
local function get_system_theme()
  local handle = io.popen("theme-switcher status 2>/dev/null | grep 'Current theme:' | cut -d: -f2 | xargs")
  if handle then
    local result = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return result ~= "" and result or "dark"
  end
  return "dark"
end

-- Available themes
M.themes = {
  light = {
    colorscheme = "tokyonight-day",
    background = "light"
  },
  dark = {
    colorscheme = "dracula", 
    background = "dark"
  }
}

-- Apply theme based on system setting
function M.apply_theme(theme_name)
  theme_name = theme_name or get_system_theme()
  local theme = M.themes[theme_name] or M.themes.dark
  
  vim.opt.background = theme.background
  
  -- Apply colorscheme safely
  local ok, _ = pcall(vim.cmd.colorscheme, theme.colorscheme)
  if not ok then
    vim.notify("Failed to load colorscheme: " .. theme.colorscheme, vim.log.levels.WARN)
    -- Fallback to default
    pcall(vim.cmd.colorscheme, "default")
  end
end

-- Auto-apply theme on startup
function M.setup()
  M.apply_theme()
  
  -- Create user command for manual theme switching
  vim.api.nvim_create_user_command("ThemeSwitch", function(opts)
    M.apply_theme(opts.args)
  end, {
    nargs = "?",
    complete = function()
      return vim.tbl_keys(M.themes)
    end,
    desc = "Switch theme (light/dark)"
  })
end

return M