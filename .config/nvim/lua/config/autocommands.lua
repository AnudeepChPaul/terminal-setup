vim.api.nvim_create_user_command("QfRemoveCurrent", function()
  if vim.bo.filetype ~= "qf" then
    print("Not in quickfix window")
    return
  end

  -- Get current cursor line in quickfix window
  local line = vim.fn.line(".")
  local total = vim.fn.line("$")

  local qf_list = vim.fn.getqflist()
  table.remove(qf_list, vim.fn.line("."))

  -- Replace quickfix list with updated one
  vim.fn.setqflist(qf_list, "r")

  -- Restore cursor position in quickfix window
  -- If last line was removed, move cursor up
  local new_total = #qf_list
  if new_total == 0 then
    vim.cmd("cclose")
    return
  end

  local new_line = math.min(line, new_total)
  vim.api.nvim_win_set_cursor(0, {new_line, 0})
end, {})

vim.api.nvim_create_user_command("QfDedup", function()
  local qflist = vim.fn.getqflist()
  local seen = {}
  local deduped = {}

  for _, item in ipairs(qflist) do
    local key = string.format("%s",
      item.filename or item.bufnr,
      item.lnum,
      item.col,
      item.text or "")

    if not seen[key] then
      seen[key] = true
      table.insert(deduped, item)
    end
  end
  vim.fn.setqflist(deduped, "r")
end, {})

vim.api.nvim_create_user_command("ReloadSnippets", function()
  require("luasnip").cleanup()
  require("luasnip.loaders.from_lua").lazy_load({
    paths = vim.g.snippet_dir,
  })
  vim.notify("🔁 Snippets reloaded!", vim.log.levels.INFO)
end, {})
