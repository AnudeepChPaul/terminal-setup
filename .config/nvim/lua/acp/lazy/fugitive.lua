return {
  "tpope/vim-fugitive",
  event = "VimEnter",
  config = function()
    local autocmd = vim.api.nvim_create_autocmd
    local AnudeepFugitive = vim.api.nvim_create_augroup("AnudeepFugitive", {})

    autocmd("BufWinEnter", {
      group = AnudeepFugitive,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        require("lualine").hide()
        local wk = require("which-key")

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, noremap = true, silent = true }

        wk.register({
          ["q"] = {
            function()
              vim.cmd.close()
              require("lualine").hide({ unhide = true })
            end,
            "Close Fugitive",
          },
          ["<leader>"] = {
            ["gc"] = { ':G commit -m "', "Git commit -m ''" },
            ["gp"] = { ":G pull --rebase ", "Git Pull --Rebase" },
            ["gP"] = { ":G push -u origin ", "Git Push -u Origin" },
          },
        }, opts)
      end,
    })
  end,
}
