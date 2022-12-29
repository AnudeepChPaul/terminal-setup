-- set colorscheme to nightfly with protected call
-- in case it isn't installed
-- local status, _ = pcall(vim.cmd, "colorscheme terafox")
local status, _ = pcall(vim.cmd, "colorscheme rose-pine")
if not status then
  print("Colorscheme not found!") -- print error if colorscheme not installed
  return
end

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

local color_status, colorizer = pcall(require, "colorizer")
if not color_status then
  return
end

colorizer.setup({
  "*",
})
