---Add vs code style snippet
---@param body string vs code style snippet string
---@param opts {ft: string}
vim.snippet.add = function(trig, body, opts)
  local ls = require("luasnip")
  if not ls then return end
  ls.add_snippets(opts.ft, { ls.parser.parse_snippet(trig, body) })
end
