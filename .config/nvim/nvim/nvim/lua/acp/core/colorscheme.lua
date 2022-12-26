-- set colorscheme to nightfly with protected call
-- in case it isn't installed

local status, _ = pcall(vim.cmd, "colorscheme nightfly")
if not status then
	return
end

local ok, nightfox = pcall(require, "nightfox")
if not ok then
	return
end

nightfox.setup({
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},
})

-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
-- local status, _ = pcall(vim.cmd, "colorscheme carbonfox")
local status, _ = pcall(vim.cmd, "colorscheme nightfox")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
