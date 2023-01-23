-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")

-- saga.init_lsp_saga({
--   server_filetype_map = {
--     typescript = "typescript",
--   },
--   -- keybinds for navigation in lspsaga window
--   move_in_saga = { prev = "<C-k>", next = "<C-j>" },
--   -- use enter to open file with finder
--   finder_action_keys = {
--     open = "<CR>",
--   },
--   -- use enter to open file with definition preview
--   definition_action_keys = {
--     edit = "<CR>",
--   },
-- })

saga.setup({
  -- keybinds for navigation in lspsaga window
  scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
  -- use enter to open file with definition preview
  definition = {
    edit = "<CR>",
  },
  ui = {
    -- colors = {
    --   normal_bg = "#022746",
    -- },
  },
})
