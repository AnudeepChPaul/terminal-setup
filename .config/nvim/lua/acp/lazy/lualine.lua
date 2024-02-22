return {
  "nvim-lualine/lualine.nvim",
  lazy = true,
  event = { "BufRead", "BufNewFile" },
  opts = function()
    return {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disable_filetypes = { "NvimTree", "packer", "fugitive", statusline = {}, winbar = {}, "git" },
        always_divide_middle = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          "mode",
          "branch",
        },
        lualine_b = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          {
            "filename",
            file_status = true,
            path = 1,
            color = { gui = "bold" },
            symbols = {
              added = "+", -- Text to show when the file is added.
              modified = "~", -- Text to show when the file is modified.
              removed = "-", -- Text to show when the file is modified.
              readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[Untitled]", -- Text to show for unnamed buffers.
              newfile = "[New]", -- Text to show for newly created file before first write
            },
          },
        },
        lualine_c = {
          "diff",
        },
        lualine_x = {
          "searchcount",
          "selectioncount",
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            -- symbols = {
            --   error = "E",
            --   warn = "W",
            --   info = "i",
            --   hint = "H",
            -- },
          },
        },
        lualine_y = {
          function()
            local msg = "No Active Lsp"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_active_clients()
            local icon = " LSP: "
            if next(clients) == nil then
              return icon .. msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return icon .. client.name
              end
            end
            return icon .. msg
          end,
        },
        lualine_z = { "progress", "location", "filesize" },
      },
      extensions = { "fugitive" },
    }
  end,
}
