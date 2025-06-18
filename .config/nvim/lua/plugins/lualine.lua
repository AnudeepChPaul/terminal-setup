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
                        path = 3,
                        symbols = {
                            added = "+",
                            modified = "~",
                            removed = "-",
                            readonly = "[-]",
                            unnamed = "[Untitled]",
                            newfile = "[New]",
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
                    },
                },
                lualine_y = {
                    function()
                        local a = ""
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
                    "encoding",
                    "fileformat",
                },
                lualine_z = { "progress", "location", "filesize" },
            },
            -- winbar = {
            --   lualine_a = {
            --     {
            --       "filename",
            --       file_status = false,
            --       path = 3,
            --     },
            --   },
            -- },
            -- inactive_winbar = {
            --   lualine_c = {
            --     { "filename", file_status = false, path = 3 },
            --   },
            -- },
            extensions = { "fugitive" },
        }
    end,
}
