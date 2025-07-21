-- Dracula colorscheme
return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Configure dracula theme
      require("dracula").setup({
        -- customize dracula color palette
        colors = {},
        -- show the '~' characters after the end of buffers
        show_end_of_buffer = true,
        -- use transparent background
        transparent_bg = false,
        -- set custom lualine background color
        lualine_bg_color = "#44475a",
        -- set italic comment
        italic_comment = true,
      })
    end,
  },

  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
