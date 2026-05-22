-- Additional plugins that enhance the editing experience
-- These plugins replace or extend functionality from the original vim configuration

return {
  -- ===================================================================
  -- TEXT MANIPULATION
  -- ===================================================================

  -- Surround text objects (replaces tpope/vim-surround)
  {
    "nvim-mini/mini.surround",
    commit = "990ce30f724d08e79670107de6b915a3f1bb9a9b",
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
    "nvim-mini/mini.align",
    commit = "c701192658ddac4e3b20956a964c2b03157b5e51",
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
    "nvim-mini/mini.trailspace",
    commit = "ae2fd422564c6e781caf6545355ca6051e20fa26",
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
    commit = "8564ce6d29ec7554eb9df578efa882d33b3c23a7",
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
    commit = "fcea7ff883235d9024dc41e638f164a450c14ca2",
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
    commit = "c0227885a06b155d5aa5465e08b9800e8c939f70",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Ensure compatibility with fugitive git plugin
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
    end,
  },

  -- Jsonnet support (same as google/vim-jsonnet)
  {
    "google/vim-jsonnet",
    commit = "4ebc6619ddce5d032a985b42a9864154c3d20e4a",
    ft = { "jsonnet", "libsonnet" },
  },

  -- HashiCorp Terraform support (replaces hashivim/vim-hashicorp-tools)
  {
    "hashivim/vim-terraform",
    commit = "520498fab16a3a11f2ae1b8cb65e0a1684bc317a",
    ft = { "terraform", "hcl" },
    config = function()
      -- Auto-format Terraform files on save
      vim.g.terraform_fmt_on_save = 1
    end,
  },
}
