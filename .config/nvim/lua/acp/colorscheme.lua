return {
  "AnudeepChPaul/dracula.nvim",
  lazy = false,
  config = function()
    vim.cmd("colorscheme dracula")

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
}
