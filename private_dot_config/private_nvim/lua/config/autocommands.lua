-- Conceal is only wanted where something renders the hidden text back: help
-- files (|links|, *tags*) and markdown prose. Notably NOT json/jsonc, where
-- treesitter conceals every quote.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("conceal_by_filetype", {clear = true}),
  pattern = {"help", "vimdoc", "markdown"},
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- Location list windows also report filetype "qf", so both commands below must
-- branch on getwininfo().loclist or they silently mutate the unrelated
-- quickfix list while you are looking at a loclist.
local function qf_context()
  if vim.bo.filetype ~= "qf" then
    return nil
  end
  local is_loclist = vim.fn.getwininfo(vim.fn.win_getid())[1].loclist == 1
  if is_loclist then
    return {
      name = "location list",
      get = function()
        return vim.fn.getloclist(0)
      end,
      set = function(items)
        vim.fn.setloclist(0, items, "r")
      end,
      close = "lclose",
    }
  end
  return {
    name = "quickfix list",
    get = vim.fn.getqflist,
    set = function(items)
      vim.fn.setqflist(items, "r")
    end,
    close = "cclose",
  }
end

vim.api.nvim_create_user_command("QfRemoveCurrent", function()
  local ctx = qf_context()
  if not ctx then
    vim.notify("Not in a quickfix or location list window", vim.log.levels.WARN)
    return
  end

  local line = vim.fn.line(".")
  local items = ctx.get()
  table.remove(items, line)
  ctx.set(items)

  if #items == 0 then
    vim.cmd(ctx.close)
    return
  end

  vim.api.nvim_win_set_cursor(0, {math.min(line, #items), 0})
end, {})

vim.api.nvim_create_user_command("QfDedup", function()
  local ctx = qf_context()
  if not ctx then
    vim.notify("Not in a quickfix or location list window", vim.log.levels.WARN)
    return
  end

  local items = ctx.get()
  local seen = {}
  local deduped = {}

  for _, item in ipairs(items) do
    -- getqflist returns bufnr, never filename
    local key = string.format("%s:%s:%s:%s", item.bufnr, item.lnum, item.col, item.text or "")
    if not seen[key] then
      seen[key] = true
      table.insert(deduped, item)
    end
  end

  ctx.set(deduped)
  local removed = #items - #deduped
  vim.notify(string.format("Removed %d duplicate%s from the %s",
    removed, removed == 1 and "" or "s", ctx.name))
end, {})

vim.api.nvim_create_user_command("ReloadSnippets", function()
  require("luasnip").cleanup()
  require("luasnip.loaders.from_lua").lazy_load({
    paths = vim.g.snippet_dir,
  })
  vim.notify("🔁 Snippets reloaded!", vim.log.levels.INFO)
end, {})
