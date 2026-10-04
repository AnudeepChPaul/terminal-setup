return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-tree/nvim-web-devicons" },
		{ "MunifTanjim/nui.nvim" },
		{ "ThePrimeagen/harpoon", branch = "harpoon2" },
	},
	opts = {
		window = {
			mappings = {
				["<cr>"] = "open",
				["<esc>"] = "cancel",
				["<c-c>"] = "cancel",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				["P"] = { "toggle_preview", config = { use_float = true } },
				-- neo-tree's default binds this to open_with_window_picker, which
				-- needs nvim-window-picker; omitting it just deep-merges the default back
				["w"] = "none",
				["e"] = function()
					vim.api.nvim_exec2("Neotree position=float focus filesystem", {})
				end,
				["b"] = function()
					vim.api.nvim_exec2("Neotree position=float focus buffers", {})
				end,
				["g"] = function()
					vim.api.nvim_exec2("Neotree position=float focus git_status", {})
				end,
				["Y"] = function(state)
					-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
					-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local results = {
						filepath,
						modify(filepath, ":."),
						modify(filepath, ":~"),
						filename,
						modify(filename, ":r"),
						modify(filename, ":e"),
					}

					-- absolute path to clipboard
					local i = vim.fn.inputlist({
						"Choose to copy to clipboard:",
						"1. Path relative to HOME: " .. results[3],
						"2. Absolute path: " .. results[1],
						"3. Path relative to CWD: " .. results[2],
						"4. Filename: " .. results[4],
						"5. Filename without extension: " .. results[5],
						"6. Extension of the filename: " .. results[6],
					})

					if i > 0 then
						local result = results[i]
						if not result then
							return print("Invalid choice: " .. i)
						end
						vim.fn.setreg("+", result)
						vim.notify("Copied: " .. result)
					end
				end,
			},
		},
		filesystem = {
			filtered_items = {
				visible = true, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = true,
				hide_gitignored = false,
				always_show = { -- remains visible even if other settings would normally hide it
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					".DS_Store",
					"thumbs.db",
				},
				hide_by_name = {
					"node_modules",
				},
			},
			commands = {
				delete = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					local popup = require("neo-tree.ui.inputs")

					popup.confirm(string.format("Sure to delete %s ? (y/n)", node.name), function(answer)
						if answer then
							vim.fn.system({ "trash", vim.fn.fnameescape(path) })
							require("neo-tree.sources.manager").refresh("filesystem")
						end
					end)
				end,
				delete_visual = function(_, nodes)
					local popup = require("neo-tree.ui.inputs")
					local paths_to_trash = {}

					for _, node in ipairs(nodes) do
						if node.type ~= "message" then
							table.insert(paths_to_trash, node.path)
						end
					end

					popup.confirm(string.format("Sure to delete %d items ? (y/n)", #paths_to_trash), function(answer)
						if answer then
							for _, node in ipairs(paths_to_trash) do
								vim.fn.system({ "trash", vim.fn.fnameescape(node) })
							end
							require("neo-tree.sources.manager").refresh("filesystem")
						end
					end)
				end,
			},
			renderers = {
				file = {
					{ "indent" },
					{ "icon" },
					{ "name", use_git_status_colors = true },
					{ "harpoon_index" },
					{
						"container",
						content = {
							{
								"symlink_target",
								zindex = 10,
								highlight = "NeoTreeSymbolicLinkTarget",
							},
							{ "clipboard", zindex = 10 },
							{ "bufnr", zindex = 10 },
							{ "modified", zindex = 20, align = "right" },
							{ "diagnostics", zindex = 20, align = "right" },
							{ "git_status", zindex = 10, align = "right" },
							{ "last_modified", zindex = 10, align = "right" },
						},
					},
					{ "diagnostics" },
					{ "git_status", highlight = "NeoTreeDimText" },
				},
			},
			components = {
				icon = function(config, node, _)
					local highlights = require("neo-tree.ui.highlights")

					local icon = config.default or " "
					local padding = config.padding or " "
					local highlight = config.highlight or highlights.FILE_ICON

					if node.type == "directory" then
						highlight = highlights.DIRECTORY_ICON
						if node:is_expanded() then
							icon = config.folder_open or "-"
						else
							icon = config.folder_closed or "+"
						end
					elseif node.type == "file" then
						local success, web_devicons = pcall(require, "nvim-web-devicons")
						if success then
							local devicon, hl = web_devicons.get_icon(node.name, node.ext)
							icon = devicon or icon
							highlight = hl or highlight
						end
					end

					return {
						text = icon .. padding,
						highlight = highlight,
					}
				end,
				harpoon_index = function(config, node, _)
					-- harpoon2 dropped get_index_of and stores values relative to cwd, while
					-- neo-tree node ids are absolute, so normalise before comparing.
					local ok, harpoon = pcall(require, "harpoon")
					local index
					if ok then
						local relative = vim.fn.fnamemodify(node:get_id(), ":.")
						for i, item in ipairs(harpoon:list().items or {}) do
							if item and item.value == relative then
								index = i
								break
							end
						end
					end
					if index then
						return {
							text = string.format("——————————► (%d)", index),
							highlight = config.highlight or "NeoTreeDirectoryIcon",
						}
					else
						return {
							text = "  ",
						}
					end
				end,
			},
		},
		default_component_configs = {
			container = {
				enable_character_fade = true,
			},
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "├",
				last_indent_marker = "└",
			},
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function()
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
			{
				event = "file_renamed",
				handler = function(args)
					-- fix references to file
					print(args.source, " renamed to ", args.destination)
				end,
			},
			{
				event = "file_moved",
				handler = function(args)
					-- fix references to file
					print(args.source, " moved to ", args.destination)
				end,
			},
		},
	},
}
