return {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        -- {
        -- 	"nvimdev/lspsaga.nvim",
        -- 	config = function()
        -- 		require("lspsaga").setup({
        -- 			ui = {
        -- 				enable = false,
        -- 				virtual_text = false,
        -- 				code_action = "",
        -- 			},
        -- 			outline = {
        -- 				keys = {
        -- 					jump = "<cr>",
        -- 				},
        -- 			},
        -- 			callhierarchy = {
        -- 				keys = {
        -- 					edit = "<cr>",
        -- 				},
        -- 			},
        -- 			typehierarchy = { keys = { edit = "<cr>" } },
        -- 		})
        -- 	end,
        -- },
        {
            "williamboman/mason.nvim",
        },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        "j-hui/fidget.nvim",
        "yioneko/nvim-vtsls",
        {
            "stevearc/conform.nvim",
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
    },

    config = function(_, opts)
        require("fidget").setup({})

        local cmp = require("cmp")
        local kind = require("lspkind")
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "vtsls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        autostart = true,
                    })
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
                ["vtsls"] = function()
                    require("lspconfig.configs").vtsls = require("vtsls").lspconfig
                    require("lspconfig").vtsls.setup({
                        capabilities = capabilities,
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "javascript.jsx",
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                        },
                        settings = {
                            typescript = {
                                preferences = {
                                    importModuleSpecifier = "non-relative",
                                },
                                tsserver = { maxTsServerMemory = 20000 },
                                inlayHints = {
                                    parameterNames = {
                                        enabled = "all",
                                        suppressWhenArgumentMatchesName = false,
                                    },
                                    parameterTypes = {
                                        enabled = true,
                                    },
                                    variableTypes = {
                                        enabled = true,
                                        suppressWhenTypeMatchesName = false,
                                    },
                                    propertyDeclarationTypes = {
                                        enabled = true,
                                    },
                                    functionLikeReturnTypes = {
                                        enabled = true,
                                    },
                                    enumMemberValues = {
                                        enabled = true,
                                    },
                                },
                                updateImportsOnFileMove = "always",
                            },
                            javascript = {
                                preferences = {
                                    importModuleSpecifier = "non-relative",
                                },
                                tsserver = { maxTsServerMemory = 20000 },
                                inlayHints = {
                                    parameterNames = {
                                        enabled = "all",
                                        suppressWhenArgumentMatchesName = false,
                                    },
                                    parameterTypes = {
                                        enabled = true,
                                    },
                                    variableTypes = {
                                        enabled = true,
                                        suppressWhenTypeMatchesName = false,
                                    },
                                    propertyDeclarationTypes = {
                                        enabled = true,
                                    },
                                    functionLikeReturnTypes = {
                                        enabled = true,
                                    },
                                    enumMemberValues = {
                                        enabled = true,
                                    },
                                },
                                updateImportsOnFileMove = "always",
                            },
                            vtsls = {
                                enableMoveToFileCodeAction = true,
                            },
                        },
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping.confirm(),
                ["<S-CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-c>"] = function(fallback)
                    cmp.mapping.abort()
                    fallback()
                end,
                ["<C-CR>"] = function(fallback)
                    cmp.abort()
                    fallback()
                end,
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
            }),
            formatting = {
                format = kind.cmp_format({
                    mode = "text_symbol",
                    maxwidth = 64,
                    ellipsis_char = "...",
                    show_labelDetails = true,
                    before = function(entry, vim_item)
                        return vim_item
                    end,
                }),
            },
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
