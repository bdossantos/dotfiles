-- Colorscheme configuration with automatic light/dark switching
return {
  -- Tokyo Night colorscheme (both light and dark modes)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
      })
    end,
  },

  -- Configure LazyVim with automatic theme detection
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Function to detect and set theme based on time
      local function get_time_based_colorscheme()
        -- Try to use our theme-mode script if available
        local theme_mode_paths = {
          vim.fn.expand("~/.dotfiles/bin/theme-mode"),
          vim.fn.expand("~/.config/nvim/../../bin/theme-mode"),
        }
        
        for _, path in ipairs(theme_mode_paths) do
          if vim.fn.executable(path) == 1 then
            local handle = io.popen(path .. " nvim-light 2>/dev/null")
            if handle then
              local light_theme = handle:read("*a"):gsub("%s+", "")
              handle:close()
              
              handle = io.popen(path .. " nvim-dark 2>/dev/null")
              if handle then
                local dark_theme = handle:read("*a"):gsub("%s+", "")
                handle:close()
                
                handle = io.popen(path .. " 2>/dev/null")
                if handle then
                  local mode = handle:read("*a"):gsub("%s+", "")
                  handle:close()
                  
                  if mode == "light" then
                    return "tokyonight-day"
                  else
                    return "tokyonight-night"
                  end
                end
              end
            end
          end
        end
        
        -- Fallback: use system time directly
        local hour = tonumber(os.date("%H"))
        if hour >= 7 and hour < 19 then
          return "tokyonight-day"
        else
          return "tokyonight-night"
        end
      end

      return {
        colorscheme = get_time_based_colorscheme(),
      }
    end,
  },
}
