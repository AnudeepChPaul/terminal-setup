-- vim.opt.background = "dark" -- set this to dark or light

-- set colorscheme to nightfly with protected call
-- in case it isn't installed
-- vim.cmd("colorscheme terafox")
-- local status, _ = pcall(vim.cmd, "colorscheme rose-pine")

local cb = require("colorbuddy.init")
local Color = cb.Color
local colors = cb.colors
local Group = cb.Group
local styles = cb.styles

vim.cmd("colorscheme oxocarbon")

Color.new("black", "#000000")
Color.new("yellow", "#f0c674")

Group.new("Error", colors.red:light(), colors.white, styles.bold)
Group.new("Visual", colors.black, colors.white, styles.bold)
Group.new("Normal", nil, nil)
Group.new("NormalFloat", nil, nil)
Group.new("NormalNC", nil, nil)
Group.new("PortalBorder", nil, nil)
Group.new("GitSignsAdd", nil, nil)
Group.new("GitSignsDelete", nil, nil)
Group.new("GitSignsChange", nil, nil)
Group.new("EndOfBuffer", nil, nil)
Group.new("LineNr", nil, nil)
Group.new("CursorLine", nil, nil)
Group.new("CursorLineNr", nil, nil)
Group.new("ColorColumn", nil, nil)
Group.new("NvimTreeNormal", nil, nil)
Group.new("VertSplit", nil, nil)
Group.new("NvimTreeWinSeparator", nil, nil)
Group.new("WinSeparator", nil, nil)
Group.new("SignColumn", nil, nil)
-- Group.new("Pmenu",  nil, nil)
