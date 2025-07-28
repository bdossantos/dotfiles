-- Code formatting configuration using conform.nvim
-- Replaces ALE for formatting functionality
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Load before writing files
  cmd = { "ConformInfo" }, -- Load when running ConformInfo command
  lazy = false, -- Don't lazy load to ensure formatting is available
  opts = {
    notify_on_error = true, -- Show notification if formatting fails

    -- Define formatters for each file type
    formatters_by_ft = {
      -- Web development
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "jq", "prettier" },
      yaml = { "prettier" },

      -- System languages
      lua = { "stylua" },
      python = { "ruff_format" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt", lsp_format = "fallback" },

      -- Shell and configuration
      sh = { "shfmt" },
    },

    -- Customize specific formatters
    formatters = {
      shfmt = {
        -- Shell formatting options: 2-space indent, compact syntax
        prepend_args = { "-i", "2", "-ci", "-s" },
      },
    },
  },
}
