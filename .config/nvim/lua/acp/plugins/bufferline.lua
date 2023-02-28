local status, bufferline = pcall(require, "bufferline")
if not status then
  print("bufferline not installed")
  return
end

bufferline.setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    diagnostics = "nvim_lsp",
  },
  highlights = {
    separator = {
      fg = "#073642",
      bg = "#002b36",
    },
    separator_selected = {
      fg = "#073642",
    },
    background = {
      fg = "#657b83",
      bg = "#002b36",
    },
    buffer_selected = {
      fg = "#fdf6e3",
      bold = true,
    },
    fill = {
      bg = "#073642",
    },
  },
})

vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
