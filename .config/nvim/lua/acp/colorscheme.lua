return {
  "AnudeepChPaul/dracula.nvim",
  lazy = false,
  config = function()
    vim.cmd("colorscheme dracula")
    require("acp.transparent").apply()
  end,
}
