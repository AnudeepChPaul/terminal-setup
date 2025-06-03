return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			exclude = { filetypes = { "dashboard", "text", "neotree", "telescope" } },
		},
	},
}
