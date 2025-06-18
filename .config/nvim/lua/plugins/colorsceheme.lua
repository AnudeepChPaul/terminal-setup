-- -- lua/plugins/rose-pine.lua
-- return {
--     "rose-pine/neovim",
--     name = "rose-pine",
--     config = function()
--         vim.o.background = "#000000"
--         require("rose-pine").setup({
--             variant = "main", -- auto, main, moon, or dawn
--             dark_variant = "main", -- main, moon, or dawn
--             dim_inactive_windows = true,
--             extend_background_behind_borders = true,
--
--             enable = {
--                 terminal = true,
--                 legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
--                 migrations = true, -- Handle deprecated options automatically
--             },
--
--             styles = {
--                 bold = true,
--                 italic = true,
--                 transparency = true,
--             },
--
--             groups = {
--                 border = "muted",
--                 link = "iris",
--                 panel = "surface",
--
--                 error = "love",
--                 hint = "iris",
--                 info = "foam",
--                 note = "pine",
--                 todo = "rose",
--                 warn = "gold",
--
--                 git_add = "foam",
--                 git_change = "rose",
--                 git_delete = "love",
--                 git_dirty = "rose",
--                 git_ignore = "muted",
--                 git_merge = "iris",
--                 git_rename = "pine",
--                 git_stage = "iris",
--                 git_text = "rose",
--                 git_untracked = "subtle",
--
--                 h1 = "iris",
--                 h2 = "foam",
--                 h3 = "rose",
--                 h4 = "gold",
--                 h5 = "pine",
--                 h6 = "foam",
--             },
--
--             palette = {
--                 -- Override the builtin palette per variant
--                 main = {
--                     base = "#000000",
--                     overlay = "#363738",
--                 },
--             },
--
--             -- NOTE: Highlight groups are extended (merged) by default. Disable this
--             -- per group via `inherit = false`
--             highlight_groups = {
--                 -- Comment = { fg = "foam" },
--                 StatusLine = { fg = "pine", bg = "none" },
--                 StatusLineNC = { fg = "pine", bg = "none" },
--                 -- VertSplit = { fg = "muted", bg = "muted" },
--                 -- Visual = { fg = "base", bg = "text", inherit = false },
--             },
--
--             before_highlight = function(group, highlight, palette)
--                 -- Disable all undercurls
--                 -- if highlight.undercurl then
--                 --     highlight.undercurl = false
--                 -- end
--                 --
--                 -- Change palette colour
--                 -- if highlight.fg == palette.pine then
--                 --     highlight.fg = palette.foam
--                 -- end
--             end,
--         })
--         vim.cmd("colorscheme rose-pine")
--     end,
-- }
return {
    { "rose-pine/neovim" },
    {
        "AnudeepChPaul/dracula.nvim",
        lazy = false,
        config = function()
            vim.cmd("colorscheme dracula-soft")

            vim.api.nvim_set_hl(0, "Error", { fg = "red", bg = "#fafafa" })
            vim.api.nvim_set_hl(0, "Visual", { fg = "#F8F8F2", bg = "#415854" })
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "PortalBorder", { bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
            vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
            vim.api.nvim_set_hl(0, "LineNr", { bg = "none", fg = "#ababab" })
            vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", fg = "#F8F8F2", bold = true })

            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#415854" })

            vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })

            vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
            vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "none" })
            vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "none", bold = true, underline = true })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

            vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopeMatching", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "none" })
            vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })

            vim.api.nvim_set_hl(0, "NeoTree", { bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { bg = "#F8F8F2", fg = "#415854" })
            vim.api.nvim_set_hl(0, "NeoTreeFloatTitle", { bg = "#F8F8F2", fg = "#415854" })
            vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = "#F8F8F2", bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeDotfile", { fg = "#F8F8F2", bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#F8F8F2", bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeHiddenByName", { fg = "#F8F8F2", bg = "none" })
            vim.api.nvim_set_hl(0, "NeoTreeWindowsHidden", { fg = "#F8F8F2", bg = "none" })
        end,
    },
}
