return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "mxsdev/nvim-dap-vscode-js" },
  },
  {
    "David-Kunz/jester",
    config = function()
      require("jester").setup({
        cmd = "jest -t '$result' -- $file",              -- run command
        identifiers = { "test", "it" },                  -- used to identify tests
        prepend = { "describe" },                        -- prepend describe blocks
        expressions = { "call_expression" },             -- tree-sitter object used to scan for tests/describe blocks
        path_to_jest_run = './node_modules/.bin/jest',   -- used to run tests
        path_to_jest_debug = './node_modules/.bin/jest', -- used for debugging
        terminal_cmd = ":vsplit | terminal",
        dap = {                                          -- debug adapter configuration
          type = 'node2',
          request = 'launch',
          cwd = vim.fn.getcwd(),
          runtimeArgs = { '--inspect-brk', '$path_to_jest', '--no-coverage', '-t', '$result', '--', '$file' },
          args = { '--no-cache' },
          sourceMaps = false,
          protocol = 'inspector',
          skipFiles = { '<node_internals>/**/*.js' },
          console = 'externalTerminal',
          port = 9229,
          disableOptimisticBPs = true
        }
      })
    end
  }
}
