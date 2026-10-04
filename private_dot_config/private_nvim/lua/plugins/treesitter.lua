local disable_function = function(lang)
	if lang == "vimdoc" then
		return true
	end
end

return {
	{
		"windwp/nvim-ts-autotag",
		-- Top level, not a dependency: lazy loads dependencies with their parent, so an
		-- `ft` on a dependency of nvim-treesitter would never actually defer anything.
		ft = {"html", "xml", "javascriptreact", "typescriptreact", "svelte", "vue", "markdown"},
		dependencies = {"nvim-treesitter/nvim-treesitter"},
		opts = {},
	},
	{
	"nvim-treesitter/nvim-treesitter",
	branch = "master", -- pinned: the main branch is a breaking API rewrite
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
	},
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	keys = {
		{ "<C-y>", desc = "Increment selection" },
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
		require("nvim-treesitter.configs").setup(opts)
	end,
},
}
