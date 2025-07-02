function _NODE_TOGGLE()
	local Terminal = require("toggleterm.terminal").Terminal
	local node = Terminal:new({
		cmd = "node",
		hidden = true,
		direction = "horizontal",
	})
	node:toggle()
end

return {
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},
	{
		"folke/snacks.nvim",
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = {
				enabled = true,
				tree = true,
				follow_file = true,
				jump = { close = false },
				config = function(opts)
					return require("snacks.picker.source.explorer").setup(opts)
				end,
				win = {
					list = {
						keys = {
							[">"] = "explorer_focus",
							["."] = "explorer_focus",
							["<"] = "explorer_up",
							["<BS>"] = "explorer_up",
							["q"] = "explorer_close",
							["I"] = "toggle_ignored",
							["H"] = "toggle_hidden",
						},
					},
				},
			},
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = true },
			styles = { enabled = false },
		},
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"ThePrimeagen/harpoon",
		lazy = true,
	},
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("undotree").setup()
		end,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		event = { "VimEnter" },
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = { "InsertEnter" },
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"arthurxavierx/vim-caser",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"stevearc/overseer.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = {},
	},
	{
		"dstein64/vim-startuptime",
		-- lazy-load on a command
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "VimEnter",
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = false,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Highlight matching word under cursor
	{ "RRethy/vim-illuminate" },
	{
		"ThePrimeagen/harpoon",
		lazy = true,
	},
	{
		"mbbill/undotree",
	},
	{
		"christoomey/vim-tmux-navigator",
		event = { "VimEnter" },
	},
	{
		"smjonas/inc-rename.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("inc_rename").setup({})
		end,
	},

	{
		"arthurxavierx/vim-caser",
		event = { "BufRead", "BufNewFile" },
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		opts = {
			suggestion = {
				enabled = not vim.g.ai_cmp,
				auto_trigger = true,
				hide_during_completion = vim.g.ai_cmp,
				keymap = {
					accept = "<tab>",
					next = "<c-j>",
					prev = "<c-k>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	-- Node REPL toggle
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<C-\>]],
				direction = "horizontal",
				start_in_insert = true,
			})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				timeout = 5000,
				stages = "fade_in_slide_out",
				render = "compact",
			})
			vim.notify = require("notify")
		end,
	},
}
