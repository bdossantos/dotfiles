-- Dracula colorscheme configuration
return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false, -- Load immediately (colorscheme should be available early)
    priority = 1000, -- High priority to load before other plugins
    config = function()
      require("dracula").setup({
        -- Dracula theme customization
        colors = {}, -- Use default dracula colors
        show_end_of_buffer = true, -- Show '~' characters after buffer end
        transparent_bg = false, -- Use dracula background color
        lualine_bg_color = "#44475a", -- Custom lualine background
        italic_comment = true, -- Italicize comments
      })
    end,
  },

  -- Configure LazyVim to use dracula as default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
