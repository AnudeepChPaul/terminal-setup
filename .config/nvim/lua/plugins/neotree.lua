local function getTelescopeOpts(state, path)
  local _path = vim.fn.fnamemodify(path, ":h")
  return {
    cwd = _path,
    search_dirs = { path = _path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        [";i"] = "telescope_grep",
        [";o"] = "telescope_find",
      },
    },
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local opts = getTelescopeOpts(state, node:get_id())
        print(node:get_id())
        opts["prompt_title"] = "Files in " .. opts.cwd
        require("telescope.builtin").find_files(opts)
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local opts = getTelescopeOpts(state, node:get_id())
        opts["prompt_title"] = "Grepping " .. opts.cwd
        require("telescope.builtin").live_grep(opts)
      end,
    },
  },
}
