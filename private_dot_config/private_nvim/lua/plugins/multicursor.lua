return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    -- Mapping-only plugin. ms is a prefix stub: lazy deletes it on first press,
    -- loads, then replays the keys. Safe only because lspsaga vacated ms.
    keys = {
      {"<C-n>", mode = {"n", "x"}, desc = "Cursor at next match"},
      {"<C-q>", mode = {"n", "x"}, desc = "Toggle cursor"},
      {"ms", mode = {"n", "x"}, desc = "Multicursor"},
    },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set
      local nx = {"n", "x"}

      set(nx, "<C-n>", function() mc.matchAddCursor(1) end, {desc = "Cursor at next match"})
      set(nx, "<C-q>", mc.toggleCursor, {desc = "Toggle cursor"})
      set(nx, "msa", mc.matchAllAddCursors, {desc = "Cursor at every match"})
      set(nx, "ms=", mc.alignCursors, {desc = "Align cursor columns"})
      set("x", "msI", mc.insertVisual, {desc = "Insert at selection start"})
      set("x", "msA", mc.appendVisual, {desc = "Append at selection end"})

      -- Layer maps are buffer-local and deleted on restore, so n/N shadow the
      -- global nzzzv/Nzzzv only while cursors exist.
      mc.addKeymapLayer(function(layer)
        layer(nx, "n", function() mc.matchAddCursor(1) end, {desc = "Cursor at next match"})
        layer(nx, "N", function() mc.matchSkipCursor(1) end, {desc = "Skip to next match"})
        layer("n", "<Esc>", function()
          if mc.cursorsEnabled() then
            mc.clearCursors()
          else
            mc.enableCursors()
          end
        end, {desc = "Clear cursors"})
      end)

      -- Not linked to Visual: colorscheme.lua paints Visual and CursorLine the
      -- same #415854, so a linked selection is invisible on the current line.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", {reverse = true})
      hl(0, "MultiCursorVisual", {fg = "#F6F6F5", bg = "#5B3E86"})
      hl(0, "MultiCursorSign", {fg = "#BAA0E8"})
      hl(0, "MultiCursorMatchPreview", {link = "Search"})
      hl(0, "MultiCursorDisabledCursor", {fg = "#1C1C1C", bg = "#70747F"})
      hl(0, "MultiCursorDisabledVisual", {fg = "#F6F6F5", bg = "#3A2B52"})
      hl(0, "MultiCursorDisabledSign", {fg = "#70747F"})
    end,
  },
}
