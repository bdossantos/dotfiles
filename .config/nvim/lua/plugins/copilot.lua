-- GitHub Copilot configuration
-- Enable Copilot for YAML file types

return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        yaml = true,
        yml = true,
      },
    },
  },
}
