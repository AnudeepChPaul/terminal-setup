vim.api.nvim_create_user_command("QfRemoveCurrent", function()
  if vim.bo.filetype ~= "qf" then
    print("Not in quickfix window")
    return
  end

  local qf_list = vim.fn.getqflist()
  table.remove(qf_list, vim.fn.line("."))
  vim.fn.setqflist(qf_list, "r")
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
