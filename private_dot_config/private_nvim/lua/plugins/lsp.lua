return {
  {
    "mason-org/mason.nvim",
    enabled = false,
    build = ":MasonUpdate",
    cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate"},
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    -- Every call site is vim.cmd.Lspsaga(...) or :Lspsaga, so the command is the trigger.
    cmd = "Lspsaga",
    config = function()
      require("lspsaga").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    -- InsertEnter only: cmp.setup.cmdline() is never called, so CmdlineEnter would
    -- pull in cmp and six dependencies on every ":" for no completion at all.
    event = "InsertEnter",
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
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "b0o/schemastore.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local inlay_hints = {
        importModuleSpecifierPreference = "non-relative",
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }

      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      local tsserver_bin = vim.fn.exepath("tsserver")
      local fallback_tsserver_lib = tsserver_bin ~= ""
          and vim.fs.joinpath(vim.fs.dirname(vim.fs.dirname(tsserver_bin)), "typescript", "lib")
        or nil

      vim.lsp.config("ts_ls", {
        init_options = {
          tsserver = { fallbackPath = fallback_tsserver_lib },
        },
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
          typescript = {
            format = { enable = true },
            inlayHints = inlay_hints,
          },
          javascript = {
            format = { enable = true },
            inlayHints = inlay_hints,
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = { vim.env.VIMRUNTIME },
              checkThirdParty = false,
            },
          },
        },
      })

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- Inlay hints are configured above but NOT switched on automatically:
      -- toggle them per buffer with `mi`.
      --
      -- Why off by default: repos with an Nx solution-style tsconfig (files: [],
      -- include: [], only references) make tsserver open a project containing no
      -- files, so every inlayHint request throws "Could not find source file"
      -- from getValidSourceFile. Seen in a large monorepo on TypeScript
      -- 5.1.6. TO RE-ENABLE ON ATTACH: set this to true.
      local INLAY_HINTS_ON_ATTACH = true

      if INLAY_HINTS_ON_ATTACH then
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("lsp_inlay_hints", { clear = true }),
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client:supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
          end,
        })
      end

      vim.lsp.enable({ "ts_ls", "jsonls", "lua_ls", "marksman", "html", "cssls", "gopls", "pylsp" })
    end,
  },
  {
    "stevearc/conform.nvim",
    -- format_on_save is configured below, so BufWritePre is exactly when it is needed.
    event = "BufWritePre",
    cmd = "ConformInfo",
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
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled= false,
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
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
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup()
    end,
  },
}
