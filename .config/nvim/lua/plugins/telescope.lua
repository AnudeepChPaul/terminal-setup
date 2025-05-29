return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		cmd = "Telescope",
		event = "VimEnter",
		version = false,
		dependencies = {
			{ "nvim-lua/plenary.nvim", version = "0.5.1" },
			{ "nvim-telescope/telescope-live-grep-args.nvim", version = "1.0.0" },
			{

				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				-- enabled = vim.fn.executable("make") == 1,
			},
		},
		opts = function()
			local lga_actions = require("telescope-live-grep-args.actions")
			local actions = require("telescope.actions")
			local telescope = require("telescope")

			local function filenameFirst(_, path)
				local tail = vim.fs.basename(path)
				local parent = vim.fs.dirname(path)
				if parent == "." then
					return tail
				end
				return string.format("%s\t\t%s", tail, parent)
			end

			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
				-- configure custom mappings
				defaults = {
					path_display = filenameFirst,
					prompt_prefix = " 🔍  ",
					dynamic_preview_title = true,
					vimgrep_arguments = {
						"rg",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--no-ignore",
						"--glob",
						"!**/.gitignore",
						"--glob",
						"!**/.git/*",
						"--glob",
						"!**/*.lock",
						"--glob",
						"!**/package-lock.json",
						"--glob",
						"!**/node_modules/*",
						"--glob",
						"!**/dist/*",
						"--glob",
						"!**/.cache/*",
						"--glob",
						"!**/coverage/*",
						"--glob",
						"!**/.idea/*",
					},
					mappings = {
						i = {
							["<c-o>"] = lga_actions.quote_prompt(),
							["<c-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),

							["<c-k>"] = actions.move_selection_previous, -- move to prev result
							["<c-j>"] = actions.move_selection_next, -- move to next result

							["<c-s>"] = actions.select_horizontal, -- select horizontal
							["<c-v>"] = actions.select_vertical, -- select vertical
							["<c-t>"] = actions.select_tab, -- select_tab
							["<c-h>"] = actions.select_horizontal, -- select horizontal

							["<c-u>"] = actions.preview_scrolling_up,
							["<c-d>"] = actions.preview_scrolling_down,
							["<c-p>"] = actions.results_scrolling_up,
							["<c-n>"] = actions.results_scrolling_down,

							["<c-q>"] = actions.send_to_qflist + actions.open_qflist,

							["<esc>"] = actions.close,
							["<c-c>"] = actions.close,
							["<c-\\>"] = actions.close,
						},

						n = {
							["<c-o>"] = lga_actions.quote_prompt(),
							["<c-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
							["<c-x>"] = actions.delete_buffer + actions.move_to_top,

							["<c-k>"] = actions.move_selection_previous, -- move to prev result
							["<c-j>"] = actions.move_selection_next, -- move to next result
							["<c-s>"] = actions.select_horizontal, -- select horizontal
							["<c-v>"] = actions.select_vertical, -- select vertical
							["<c-t>"] = actions.select_tab, -- select tab

							["<c-u>"] = actions.preview_scrolling_up,
							["<c-d>"] = actions.preview_scrolling_down,
							["<c-p>"] = actions.results_scrolling_up,
							["<c-n>"] = actions.results_scrolling_down,

							["<c-q>"] = actions.send_to_qflist + actions.open_qflist,

							["<esc>"] = actions.close,
							["<c-c>"] = actions.close,
							["<c-\\>"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--line-number",
							"--column",
							"--smart-case",
							"--hidden",
							"--no-ignore",
							"--glob",
							"!**/.gitignore",
							"--glob",
							"!**/.git/*",
							"--glob",
							"!**/*.lock",
							"--glob",
							"!**/package-lock.json",
							"--glob",
							"!**/node_modules/*",
							"--glob",
							"!**/dist/*",
							"--glob",
							"!**/.cache/*",
							"--glob",
							"!**/coverage/*",
							"--glob",
							"!**/.idea/*",
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
		end,
	},
}
