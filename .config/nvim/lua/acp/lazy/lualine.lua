return {
  "nvim-lualine/lualine.nvim",
  lazy = true,
  event = { "BufRead", "BufNewFile" },
  opts = function()
    return {
      sections = {
        lualine_a = {
          "mode",
          "FugitiveHead",
        },
        lualine_b = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            file_status = true,
            path = 1,
            color = { gui = "bold" },
            symbols = {
              modified = "[+]", -- Text to show when the file is modified.
              readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[Untitled]", -- Text to show for unnamed buffers.
              newfile = "[New]", -- Text to show for newly created file before first write
            },
          },
          "progress",
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = "E",
              warn = "W",
              info = "i",
              hint = "H",
            },
          },
        },
      },
    }
  end,
}
