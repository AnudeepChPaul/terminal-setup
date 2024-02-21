vim.g.copilot_node_command = "$HOME/.nvm/versions/node/v18.17.1/bin/node"

return {
    "github/copilot.vim", 
    event = { "BufRead", "BufNewFile" }
}
