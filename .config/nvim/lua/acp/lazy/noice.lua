return {
  {
    "folke/noice.nvim",
    event = { "CmdlineEnter" },
    config = function()
      require("noice").setup({
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = true,
        },
      })
    end,
  },
}
