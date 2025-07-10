-- Set global snippet path early
vim.g.snippet_dir = vim.fn.stdpath("config") .. "/lua/snippets"

vim.api.nvim_create_user_command("ReloadSnippets", function()
	require("luasnip").cleanup()
	require("luasnip.loaders.from_lua").lazy_load({
		paths = vim.g.snippet_dir,
	})
	vim.notify("🔁 Snippets reloaded!", vim.log.levels.INFO)
end, {})

return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
		lazy = false,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			require("luasnip").cleanup()
			require("luasnip.loaders.from_lua").lazy_load({
				paths = vim.g.snippet_dir,
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-c>"] = function(fallback)
						if cmp.visible() then
							cmp.abort()
						end
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)
					end,
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
				-- Optional: open menu as you type
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufNewFile" },
		dependencies = {
			"b0o/schemastore.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				event = { "BufRead", "BufNewFile" },
				config = function()
					require("mason").setup({
						ui = {
							border = "rounded",
							icons = {
								package_installed = "✓",
								package_pending = "➜",
								package_uninstalled = "✗",
							},
						},
					})
				end,
			},
		},
		config = function(_)
			local lspconfig = require("lspconfig")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			require("mason-lspconfig").setup({
				ensure_installed = { "ts_ls", "jsonls", "lua_ls", "marksman", "html", "cssls", "emmet_ls" },
				automatic_installation = true,
				handlers = {
					function(server)
						lspconfig[server].setup({ capabilities = capabilities })
					end,
					ts_ls = function()
						lspconfig.ts_ls.setup({
							capabilities = capabilities,
							settings = {
								completions = {
									completeFunctionCalls = true,
								},
								typescript = {
									format = {
										enable = true,
									},
									inlayHints = {
										importModuleSpecifierPreference = "non-relative",
										includeInlayParameterNameHints = "all",
										includeInlayParameterNameHintsWhenArgumentMatchesName = false,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = true,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
								javascript = {
									format = {
										enable = true,
									},
									inlayHints = {
										importModuleSpecifierPreference = "non-relative",
										includeInlayParameterNameHints = "all",
										includeInlayParameterNameHintsWhenArgumentMatchesName = false,
										includeInlayFunctionParameterTypeHints = true,
										includeInlayVariableTypeHints = true,
										includeInlayPropertyDeclarationTypeHints = true,
										includeInlayFunctionLikeReturnTypeHints = true,
										includeInlayEnumMemberValueHints = true,
									},
								},
							},
						})
					end,
					lua_ls = function()
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim", "require" },
									},
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
										checkThirdParty = false,
									},
								},
							},
						})
					end,
					json_ls = function()
						lspconfig.jsonls.setup({
							capabilities = capabilities,
							settings = {
								json = {
									schemas = require("schemastore").json.schemas(),
									validate = { enable = true },
								},
							},
						})
					end,
					emmet_ls = function()
						lspconfig.emmet_ls.setup({
							capabilities = capabilities,
							filetypes = {
								"html",
								"css",
								"scss",
								"javascript",
								"javascriptreact",
								"typescriptreact",
								"vue",
								"svelte",
								"xml",
							},
							init_options = {
								html = {
									options = {
										["bem.enabled"] = true,
									},
								},
							},
						})
					end,
				},
			})

			-- lspconfig.marksman.setup({capabilities = capabilities})
			-- lspconfig.html.setup({capabilities = capabilities})
			-- lspconfig.cssls.setup({capabilities = capabilities})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufRead", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				["javascript"] = { "prettier" },
				["javascriptreact"] = { "prettier" },
				["typescript"] = { "prettier" },
				["typescriptreact"] = { "prettier" },
				["vue"] = { "prettier" },
				["css"] = { "prettier" },
				["scss"] = { "prettier" },
				["less"] = { "prettier" },
				["html"] = { "prettier" },
				["json"] = { "prettier" },
				["jsonc"] = { "prettier" },
				["yaml"] = { "prettier" },
				["markdown"] = { "prettier" },
				["markdown.mdx"] = { "prettier" },
				["graphql"] = { "prettier" },
				["handlebars"] = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
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
					accept = "<c-l>",
					next = "<c-j>",
					prev = "<c-k>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
				javascript = true,
				typescript = true,
				["*"] = true, -- Enable for all filetypes
			},
		},
	},
	{
		"smjonas/inc-rename.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("inc_rename").setup()
		end,
	},
}
