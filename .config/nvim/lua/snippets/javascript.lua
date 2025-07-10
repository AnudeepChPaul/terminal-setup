local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- Returns filename without extension
local function filename()
	return vim.fn.expand("%:t:r")
end

return {
	-- Arrow Function
	s(
		"fna",
		fmt(
			[[
const {} = ({}) => {{
  {}
}};
]],
			{
				i(1, "functionName"), -- 1: function name
				i(2, "params"),
				i(0),
			}
		)
	),

	s(
		"fn",
		fmt(
			[[
function {} ({}) {{
  {}
}};
]],
			{
				i(1, "functionName"), -- 1: function name
				i(2, "params"),
				i(0),
			}
		)
	),

	-- Typed React Functional Component
	s(
		"trfc",
		fmt(
			[[
import React from 'react';

interface {}Props {{
  // define props here
}}

const {}: React.FC<{}Props> = (props: {}Props) => {{
  return (
    <div>{}</div>
  );
}};

export default {};
]],
			{
				rep(1), -- 2: repeat for component const
				i(1, f(filename)), -- 1: filename
				rep(1), -- 2: repeat for component const
				rep(1), -- 3: repeat for prop typing
				i(0), -- 4: inner JSX
				rep(1), -- 5: export default
			}
		)
	),
}
