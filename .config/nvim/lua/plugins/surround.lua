return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    -- Configuration here, or leave empty to use defaults
    require("nvim-surround").setup()
  end,
}
