-- Additional plugins that enhance the editing experience
-- These plugins replace or extend functionality from the original vim configuration

return {
  -- ===================================================================
  -- TEXT MANIPULATION
  -- ===================================================================

  -- Surround text objects (replaces tpope/vim-surround)
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        {
          opts.mappings.update_n_lines,
          desc = "Update `MiniSurround.config.n_lines`",
        },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },

  -- Text alignment (replaces godlygeek/tabular)
  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "n", "v" }, desc = "Align with delimiter" },
      { "gA", mode = { "n", "v" }, desc = "Align with preview" },
    },
    opts = {},
  },

  -- ===================================================================
  -- VISUAL ENHANCEMENTS
  -- ===================================================================

  -- Trailing whitespace management (replaces ntpeters/vim-better-whitespace)
  {
    "echasnovski/mini.trailspace",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.trailspace").setup()
      -- Automatically highlight trailing whitespace
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
        pattern = "*",
        callback = function()
          require("mini.trailspace").highlight()
        end,
        desc = "Highlight trailing whitespace",
      })
    end,
  },

  -- Zen mode for distraction-free writing (replaces junegunn/goyo.vim + limelight.vim)
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
    },
    opts = {
      plugins = {
        gitsigns = true, -- Show git signs in zen mode
        tmux = true, -- Integrate with tmux if available
        kitty = { enabled = false, font = "+2" },
      },
    },
  },

  -- ===================================================================
  -- NAVIGATION AND MOVEMENT
  -- ===================================================================

  -- Enhanced motion (replaces Lokaltog/vim-easymotion)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle flash search",
      },
    },
  },

  -- ===================================================================
  -- FILE TYPE SUPPORT
  -- ===================================================================

  -- EditorConfig support (same as editorconfig/editorconfig-vim)
  {
    "editorconfig/editorconfig-vim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Ensure compatibility with fugitive git plugin
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
    end,
  },

  -- Jsonnet support (same as google/vim-jsonnet)
  {
    "google/vim-jsonnet",
    ft = { "jsonnet", "libsonnet" },
  },

  -- HashiCorp Terraform support (replaces hashivim/vim-hashicorp-tools)
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },
    config = function()
      -- Auto-format Terraform files on save
      vim.g.terraform_fmt_on_save = 1
    end,
  },
}
