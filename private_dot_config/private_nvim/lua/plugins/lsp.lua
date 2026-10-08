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
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      require("luasnip").cleanup()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.g.snippet_dir,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      keymap = {
        preset = "none",
        -- Under tmux the terminal sends Ctrl+Space as NUL, which nvim reads as <C-@>.
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-@>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-c>"] = {
          function(blink)
            blink.hide()
          end,
          "fallback",
        },
      },
      -- The dracula fork styles nvim-cmp groups only, so borrow those.
      appearance = { use_nvim_cmp_as_default = true },
      completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
      },
      signature = { enabled = true },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = { enabled = false },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "b0o/schemastore.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      local inlay_hints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      }

      local ts_language_settings = {
        format = { enable = true },
        inlayHints = inlay_hints,
        preferences = { importModuleSpecifier = "non-relative" },
        suggest = { completeFunctionCalls = true },
        updateImportsOnFileMove = { enabled = "always" },
      }

      vim.lsp.config("vtsls", {
        settings = {
          complete_function_calls = true,
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = { enableServerSideFuzzyMatch = true },
            },
          },
          typescript = vim.tbl_extend("force", ts_language_settings, {
            tsserver = { maxTsServerMemory = 8192 },
          }),
          javascript = ts_language_settings,
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

      local INLAY_HINTS_ON_ATTACH = true

      local progress_by_client = vim.defaulttable()
      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.api.nvim_create_autocmd("LspProgress", {
        group = vim.api.nvim_create_augroup("lsp_progress_notify", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local value = args.data.params.value
          if not client or type(value) ~= "table" then
            return
          end
          local tasks = progress_by_client[client.id]
          local token = args.data.params.token
          local task_index = #tasks + 1
          for index, task in ipairs(tasks) do
            if task.token == token then
              task_index = index
              break
            end
          end
          tasks[task_index] = {
            token = token,
            done = value.kind == "end",
            message = string.format("[%3d%%] %s%s",
              value.kind == "end" and 100 or value.percentage or 0,
              value.title or "",
              value.message and (" " .. value.message) or ""),
          }
          local lines = {}
          progress_by_client[client.id] = vim.tbl_filter(function(task)
            table.insert(lines, task.message)
            return not task.done
          end, tasks)
          vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, {
            id = "lsp_progress_" .. client.id,
            title = client.name,
            opts = function(notification)
              notification.icon = #progress_by_client[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })

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

      vim.lsp.enable({ "vtsls", "eslint", "graphql", "jsonls", "lua_ls", "marksman", "html", "cssls", "gopls", "pylsp" })
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
