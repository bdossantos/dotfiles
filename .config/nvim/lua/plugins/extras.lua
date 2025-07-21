-- Additional plugins to match original vim configuration
return {
  -- Surround plugin (tpope/vim-surround equivalent)
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
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

  -- Whitespace management (ntpeters/vim-better-whitespace equivalent)
  {
    "echasnovski/mini.trailspace",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.trailspace").setup()
      -- Highlight trailing whitespace
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
        pattern = "*",
        callback = function()
          require("mini.trailspace").highlight()
        end,
      })
    end,
  },

  -- Easy motion (Lokaltog/vim-easymotion equivalent)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Tabular alignment (godlygeek/tabular equivalent)
  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "n", "v" }, desc = "Align" },
      { "gA", mode = { "n", "v" }, desc = "Align with preview" },
    },
    opts = {},
  },

  -- Focus mode (junegunn/goyo.vim + junegunn/limelight.vim equivalent)
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- EditorConfig support (editorconfig/editorconfig-vim equivalent)
  {
    "editorconfig/editorconfig-vim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Ensure that this plugin works well with fugitive
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*" }
    end,
  },

  -- Jsonnet support (google/vim-jsonnet equivalent)
  {
    "google/vim-jsonnet",
    ft = { "jsonnet", "libsonnet" },
  },

  -- HashiCorp tools support (hashivim/vim-hashicorp-tools equivalent)
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },
    config = function()
      vim.g.terraform_fmt_on_save = 1
    end,
  },
}