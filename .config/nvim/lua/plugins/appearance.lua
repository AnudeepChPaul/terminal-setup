local Util = require("lazyvim.util")

return {
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = true,
  --   priority = 100,
  --   opts = function()
  --     return {
  --       transparent = true,
  --     }
  --   end,
  -- },
  {
    "AnudeepChPaul/dracula.nvim",
    lazy = true,
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        sections = {
          lualine_c = {
            Util.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = "E",
                warn = "W",
                info = "i",
                hint = "H",
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              file_status = true,
              path = 1,
              symbols = { modified = "[+]", readonly = "[-]", unnamed = "[Untitled]", newfile = "[New]" },
            },
          },
        },
      }
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
 █████╗ ███╗   ██╗██╗   ██╗██████╗ ███████╗███████╗███████╗██████╗
██╔══██╗████╗  ██║██║   ██║██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗
███████║██╔██╗ ██║██║   ██║██║  ██║█████╗  █████╗  █████╗  ██████╔╝
██╔══██║██║╚██╗██║██║   ██║██║  ██║██╔══╝  ██╔══╝  ██╔══╝  ██╔═══╝
██║  ██║██║ ╚████║╚██████╔╝██████╔╝███████╗███████╗███████╗██║
╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
