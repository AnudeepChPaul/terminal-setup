-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local lga_actions = require("telescope-live-grep-args.actions")

-- configure telescope
telescope.setup({
	extensions = {
		live_grep_args = {
			auto_quoting = true,
			mappings = { -- extend mappings
				i = {
					["<C-o>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
		},
	},

	-- configure custom mappings
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
