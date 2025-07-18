local disable_function = function(lang)
	local buf_name = vim.fn.expand("%")
	print(buf_name, lang)
	if lang == "vimdoc" then
		return true
	end
end

return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old and doesn't work on Windows
	build = ":TSUpdate",
	event = { "BufRead", "BufNewFile" },
	init = function(plugin)
		-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
		-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
		-- no longer trigger the **nvim-treeitter** module to be loaded in time.
		-- Luckily, the only thins that those plugins need are the custom queries, which we make available
		-- during startup.
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			config = function()
				-- When in diff mode, we want to use the default
				-- vim text objects c & C instead of the treesitter ones.
				local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
				local configs = require("nvim-treesitter.configs")

				for name, fn in pairs(move) do
					if name:find("goto") == 1 then
						move[name] = function(q, ...)
							if vim.wo.diff then
								local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
								for key, query in pairs(config or {}) do
									if q == query and key:find("[%]%[][cC]") then
										vim.cmd("normal! " .. key)
										return
									end
								end
							end
							return fn(q, ...)
						end
					end
				end
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			enabled = true,
			opts = { mode = "cursor", max_lines = 3 },
			event = { "BufRead", "BufNewFile" },
			keys = {
				{
					"<leader>ut",
					function()
						require("treesitter-context").toggle()
					end,
					desc = "Toggle Treesitter Context",
				},
			},
		},
		{
			"windwp/nvim-ts-autotag",
			event = { "BufRead", "BufNewFile" },
			opts = {},
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		},
	},
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	keys = {
		{ "<c-space>", desc = "Increment selection" },
		{ "<bs>", desc = "Decrement selection", mode = "x" },
	},
	opts = {
		highlight = { enable = true, disable = disable_function },
		indent = { enable = true },
		ensure_installed = {
			"bash",
			"diff",
			"html",
			"javascript",
			"tsx",
			"typescript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"toml",
			"yaml",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-y>",
				node_incremental = "<C-y>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},
	config = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			---@type table<string, boolean>
			local added = {}
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end
		require("nvim-treesitter.configs").setup(opts)
	end,
}
