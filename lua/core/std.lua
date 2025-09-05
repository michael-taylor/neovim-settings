---Add VS Code style snippet
---@param body string VS Code style snippet string
---@param opts {file type: string}
vim.snippet.add = function(trig, body, opts)
  local ls = require("luasnip")
  if not ls then return end
  ls.add_snippets(opts.ft, { ls.parser.parse_snippet(trig, body) })
end

local std_opts = { desc = desc, noremap = true, silent = true }
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

---Map a keystroke for INSERT mode
---@param lhs {the keystroke: string}
---@param rhs the operation
---@param opts a map of the mapping options
function mapi(lhs, rhs, opts)
  map("i", lhs, rhs, opts)
end

---Map a keystroke for INSERT mode
---@param lhs {the keystroke: string}
---@param rhs the operation
function mapi(lhs, rhs)
  map("i", lhs, rhs, std_opts)
end

---Map a keystroke for NORMAL mode
---@param lhs {the keystroke: string}
---@param rhs the operation
---@param opts a map of the mapping options
function mapn(lhs, rhs, opts)
  map("n", lhs, rhs, opts)
end

---Map a keystroke for NORMAL mode
---@param lhs {the keystroke: string}
---@param rhs the operation
function mapn(lhs, rhs)
  map("n", lhs, rhs, std_opts)
end

---Map a keystroke for VISUAL and SELECT modes
---@param lhs {the keystroke: string}
---@param rhs the operation
---@param opts a map of the mapping options
function mapv(lhs, rhs, opts)
  map("v", lhs, rhs, opts)
end

---Map a keystroke for VISUAL and SELECT modes
---@param lhs {the keystroke: string}
---@param rhs the operation
function mapv(lhs, rhs)
  map("v", lhs, rhs, std_opts)
end

---Map a keystroke for VISUAL mode
---@param lhs {the keystroke: string}
---@param rhs the operation
---@param opts a map of the mapping options
function mapx(lhs, rhs, opts)
  map("x", lhs, rhs, opts)
end

---Map a keystroke for VISUAL mode
---@param lhs {the keystroke: string}
---@param rhs the operation
function mapx(lhs, rhs)
  map("x", lhs, rhs, std_opts)
end
