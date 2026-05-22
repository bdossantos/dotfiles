-- GitHub Copilot configuration
-- Enable Copilot for YAML file types

return {
  {
    "zbirenbaum/copilot.lua",
    commit = "407349117f176789df6ec1c23bca72f34e15b4e8",
    opts = {
      filetypes = {
        yaml = true,
        yml = true,
      },
    },
  },
}
