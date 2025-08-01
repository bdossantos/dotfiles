-- Dynamic colorscheme configuration with theme switching support
return {
  -- Dracula theme (dark)
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("dracula").setup({
        colors = {},
        show_end_of_buffer = true,
        transparent_bg = false,
        lualine_bg_color = "#44475a",
        italic_comment = true,
      })
    end,
  },
  
  -- Tokyo Night theme (light variant)
  {
    "folke/tokyonight.nvim",
    lazy = false, 
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "day", -- Use day variant for light theme
        light_style = "day",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
      })
    end,
  },

  -- Configure LazyVim to use dynamic theme
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Load theme configuration
      local theme_config = require("config.theme")
      theme_config.setup()
      
      return {
        -- Default to dark theme, will be overridden by theme switcher
        colorscheme = "dracula",
      }
    end,
  },
}
