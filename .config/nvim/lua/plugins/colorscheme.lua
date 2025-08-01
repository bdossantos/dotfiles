-- Colorscheme configuration with automatic light/dark switching
return {
  -- GitHub colorscheme (both light and dark modes)
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          compile_file_suffix = "_compiled",
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          transparent = false,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
        },
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
                    return "github_light_high_contrast"
                  else
                    return "github_dark_high_contrast"
                  end
                end
              end
            end
          end
        end
        
        -- Fallback: use system time directly
        local hour = tonumber(os.date("%H"))
        if hour >= 7 and hour < 19 then
          return "github_light_high_contrast"
        else
          return "github_dark_high_contrast"
        end
      end

      return {
        colorscheme = get_time_based_colorscheme(),
      }
    end,
  },
}
