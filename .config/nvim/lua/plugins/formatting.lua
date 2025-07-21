-- Formatting and linting configuration (replaces ALE)
return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    init = function()
      -- Install conform formatters on VeryLazy
      LazyVim.on_very_lazy(function()
        LazyVim.format.register({
          name = "conform.nvim",
          priority = 100,
          primary = false,
          format = function(buf)
            require("conform").format({ bufnr = buf })
          end,
          sources = function(buf)
            local ret = require("conform").list_formatters(buf)
            return vim.tbl_map(function(v)
              return v.name
            end, ret)
          end,
        })
      end)
    end,
    opts = function()
      local plugin = require("lazy.core.config").spec.plugins["conform.nvim"]
      local opts = plugin and plugin.opts or {}
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        ["javascript"] = { "prettier", "eslint" },
        ["javascriptreact"] = { "prettier", "eslint" },
        ["typescript"] = { "prettier", "eslint", "tslint" },
        ["typescriptreact"] = { "prettier", "eslint" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
        ["sh"] = { "shfmt" },
        ["lua"] = { "stylua" },
      }
      opts.format_on_save = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_fallback = true,
      }
      return opts
    end,
  },
}
