return {
  transparent = function()
      vim.api.nvim_set_hl(0, "Error", { fg = "red", bg = "#fafafa" })
      vim.api.nvim_set_hl(0, "Visual", { fg = "#000000", bg = "#fafafa" })
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "PortalBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000000" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })

      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#fafafa", fg = "#000000" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

      vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "none" })

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
  end,
}