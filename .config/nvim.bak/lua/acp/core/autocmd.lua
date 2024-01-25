local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

local pre_custom_command = function()
  autocmd("BufWritePre", {
    group = augroup("nvim_pre_custom_command", { clear = true }),
    callback = function()
      vim.lsp.buf.format({ buffer = vim.api.nvim_get_current_buf() })
      vim.api.nvim_command(":retab")
      vim.api.nvim_command(":CocCommand eslint.executeAutofix")
    end,
  })
end

local function open_temporary_output_buffer(command)
  local temp_buffer = vim.api.nvim_create_buf(true, true)
  if command ~= nil then
    vim.fn.jobstart(command, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(temp_buffer, -1, -1, false, data)
        end
      end,
      on_stderr = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(temp_buffer, -1, -1, false, data)
        end
      end,
    })
  end
  vim.api.nvim_open_win(temp_buffer, true, {
    relative = "win",
    width = 40,
    height = 30,
    row = 1,
    col = 80,
    border = "rounded",
    noautocmd = true,
  })
end

local attach_to_buffer = function(pattern, cmd)
  autocmd("BufWritePost", {
    group = augroup("nvim_go_post_custom_command", { clear = true }),
    pattern = pattern,
    callback = function()
      open_temporary_output_buffer(cmd)
    end,
  })
end

-- vim.api.crea
vim.api.nvim_create_user_command("AutoRunGo", function()
  local pattern = vim.fn.input("Pattern: ")
  local command = vim.split(vim.fn.input("Command: "), " ")

  if pattern == "" then
    pattern = "*.go"
  end

  attach_to_buffer(pattern, command)
end, {})

vim.api.nvim_create_user_command("AutoRunJS", function()
  local pattern = vim.fn.input("Pattern: ")
  local command = vim.split(vim.fn.input("Command: "), " ")

  if pattern == "" then
    pattern = "*.js"
  end

  attach_to_buffer(pattern, command)
end, {})

vim.api.nvim_create_user_command("AutoRunTS", function()
  local pattern = vim.fn.input("Pattern: ")
  local command = vim.split(vim.fn.input("Command: "), " ")

  if pattern == "" then
    pattern = "*.ts"
  end

  attach_to_buffer(pattern, command)
end, {})

vim.api.nvim_create_user_command("AutoRunPy", function()
  local pattern = vim.fn.input("Pattern: ")
  local command = vim.split(vim.fn.input("Command: "), " ")

  if pattern == "" then
    pattern = "*.py"
  end

  attach_to_buffer(pattern, command)
end, {})

vim.api.nvim_create_user_command("AutoStop", function()
  augroup("nvim_go_post_custom_command", { clear = true })
end, {})

vim.api.nvim_create_user_command("FormatOnSaveClear", function()
  augroup("nvim_pre_custom_command", { clear = true })
end, {})

vim.api.nvim_create_user_command("FormatOnSave", function()
  pre_custom_command()
end, {})

-- vim.api.nvim_create_augroup("CocGroup", {})
-- -- pre_custom_command()
-- vim.api.nvim_create_autocmd("CursorHold", {
--     group = "CocGroup",
--     command = "silent call CocActionAsync('highlight')",
--     desc = "Highlight symbol under cursor on CursorHold"
-- })
