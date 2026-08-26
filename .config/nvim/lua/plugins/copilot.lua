-- GitHub Copilot configuration
-- Enable Copilot for YAML file types

return {
  {
    "zbirenbaum/copilot.lua",
    commit = "7e6723aabea044519462958ffcea68d7985c5ed0",
    opts = {
      filetypes = {
        yaml = true,
        yml = true,
      },
    },
  },
}
