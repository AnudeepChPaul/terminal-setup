-- vim.opt.background = "dark" -- set this to dark or light
vim.cmd("colorscheme oxocarbon")

-- set colorscheme to nightfly with protected call
-- in case it isn't installed
-- vim.cmd("colorscheme terafox")
-- local status, _ = pcall(vim.cmd, "colorscheme rose-pine")

--[[ vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "PortalBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" }) ]]

--[[ local color_status, colorizer = pcall(require, "colorizer")
if not color_status then
  return
end

colorizer.setup({
  "*",
}) ]]
