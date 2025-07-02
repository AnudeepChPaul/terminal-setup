return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			indent = { char = "│" },
			scope = { enabled = true },
			exclude = {
				filetypes = { "dashboard", "text", "neotree", "telescope", "help", "lazy", "NvimTree", "terminal" },
				buftypes = { "terminal", "nofile" },
			},
		},
	},
}
