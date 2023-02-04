function sleep(n)
  local t = os.clock()
  while os.clock() - t <= n do
    -- nothing
  end
end

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

autocmd("BufEnter", {
  group = augroup("nvim_buffer_enter_command", { clear = true }),
  callback = function()
    local ft = vim.bo.filetype

    if ft == "lua" then
    elseif ft == "go" then
    else
    end
  end,
})

autocmd("BufWritePre", {
  group = augroup("nvim_pre_custom_command", { clear = true }),
  callback = function()
    vim.lsp.buf.format({ buffer = vim.api.nvim_get_current_buf() })
    vim.api.nvim_command(":retab")
  end,
})

local attach_to_buffer = function(output_buffer, pattern, command)
  autocmd("BufWritePost", {
    group = augroup("nvim_go_post_custom_command", { clear = true }),
    pattern = pattern,
    callback = function()
      print("We saved a .go file")
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(output_buffer, -1, -1, false, data)
          end
        end,
        on_stderr = function(_, data)
          if data then
            vim.api.nvim_buf_set_lines(output_buffer, -1, -1, false, data)
          end
        end,
      })
    end,
  })
end

attach_to_buffer(0, "main.go", { "go", "run", "main.go" })

-- vim.api.crea
vim.api.nvim_create_user_command("AutoRunGo", function()
  local bufnr = vim.fn.input("Buffer number: ")
  local pattern = vim.fn.input("Pattern: ")
  local command = vim.split(vim.fn.input("Command: "), " ")

  attach_to_buffer(bufnr, pattern, command)
end, {})

vim.api.nvim_create_user_command("AutoStop", function()
  augroup("nvim_go_post_custom_command", { clear = true })
end, {})
