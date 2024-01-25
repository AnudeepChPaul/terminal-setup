local Util = require("lazyvim.util")
-- local icons = require("lazyvim.config").icons

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
}
