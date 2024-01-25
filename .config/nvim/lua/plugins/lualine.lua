local Util = require("lazyvim.util")
local icons = require("lazyvim.config").icons

return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    return {
      sections = {
        lualine_c = {
          Util.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { Util.lualine.pretty_path() },
          {
            "filename",
            file_status = true,
            path = 0,
            symbols = { modified = "[+]", readonly = "[-]", unnamed = "[Untitled]", newfile = "[New]" },
          },
        },
      },
    }
  end,
}
