local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- Function to get the current filename (no extension)
local function filename()
  return vim.fn.expand("%:t:r")
end


return {
  s("fna", fmt(
    [[
const {} = ({}) => {{
  {}
}};
]],
    {
      i(1, "functionName"),
      i(2, "params"),
      i(0),
    }
  )),

  s("fn", fmt(
    [[
function {}({}) {{
  {}
}};
]],
    {
      i(1, "functionName"),
      i(2, "params"),
      i(0),
    }
  )),
}
