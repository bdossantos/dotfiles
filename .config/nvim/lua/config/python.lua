-- Python host configuration for Neovim
-- Prefer virtual environment python if available, otherwise use system python

local venv = os.getenv("VIRTUAL_ENV")
if venv then
  -- Use python from virtual environment if one is active
  vim.g.python3_host_prog = venv .. "/bin/python3"
else
  -- Fall back to system python3
  local python_path = vim.fn.system("which python3"):gsub("%s+", "")
  if python_path and python_path ~= "" then
    vim.g.python3_host_prog = python_path
  end
end
