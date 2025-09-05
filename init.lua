--[[
  A configuration for Neovim that uses Neovim's native plugin management (v0.12+). Only plugins 
  that offer a lot of convience with little overhead will be included.

  Required system utilities:

  * bat
  * curl
  * fd
  * fzf
  * git
  * rg
  * tar
  * tree-sitter
  * unzip
--]]

--[[
  TODO:
  * Highlight current completion (maybe also change to TAB to select)
  * LSP diagnostics
]]

require("core.std")
require("core.options")

--Create an autogroup to use during config (set "clear" here, but not elseware)
local augroup = vim.api.nvim_create_augroup("michaeltaylor.cfg", { clear = true })

local groups = {
  vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true),
  vim.api.nvim_get_runtime_file("lua/languages/*.lua", true),
}
for _, files in ipairs(groups) do
  for _, path in ipairs(files) do
    dofile(path)
  end
end

-- Wait until after plugins are loaded to set the keymaps
require("core.keymaps")
