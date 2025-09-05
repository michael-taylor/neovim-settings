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
  * Remove modeline in insert mode
  * LSP diagnostics
]]

--[[ File-type specific options ]]
local augroup = vim.api.nvim_create_augroup("michaeltaylor.cfg", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

local function load_file(path)
  local co = coroutine.running()
  vim.defer_fn(function()
    dofile(path)
    coroutine.resume(co)
  end, 2)
  coroutine.yield()
end

coroutine.wrap(function()
  local groups = {
    vim.api.nvim_get_runtime_file("lua/core/*.lua", true),
    vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true),
    vim.api.nvim_get_runtime_file("lua/languages/*.lua", true),
  }
  for _, files in ipairs(groups) do
    for _, path in ipairs(files) do
      load_file(path)
    end
  end
end)()
