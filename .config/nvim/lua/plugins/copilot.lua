-- GitHub Copilot configuration
-- Enable Copilot for YAML file types

return {
  {
    "zbirenbaum/copilot.lua",
    commit = "d1570ddc00fc4fc4caf7422803805ee22cca14ff",
    opts = {
      filetypes = {
        yaml = true,
        yml = true,
      },
    },
  },
}
