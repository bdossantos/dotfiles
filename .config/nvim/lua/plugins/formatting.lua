-- Formatting and linting configuration (replaces ALE)
return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  lazy = false,
  opts = {
    notify_on_error = true,
    formatters_by_ft = {
      fish = { "fish_indent" },
      javascript = { "prettier" },
      lua = { "stylua" },
      python = { "ruff_format" },
      sh = { "shfmt" },
      yaml = { "prettier" },
      go = { "goimports", "gofmt" },
      json = { "jq", "prettier" },
      just = { "just" },
      rust = { "rustfmt", lsp_format = "fallback" },
    },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci", "-s" },
      },
    },
  },
}
