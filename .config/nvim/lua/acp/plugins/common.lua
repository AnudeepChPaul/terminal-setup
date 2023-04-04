-- Setup neovim lua configuration
-- require("neodev").setup()

-- Turn on lsp status information

local nv_status, nvt = pcall(require, "nvterm")

if not nv_status then
  return
end

nvt.setup({
  terminals = {
    shell = vim.o.shell,
    list = {},
    type_opts = {
      float = {
        relative = "editor",
        row = 0.3,
        col = 0.25,
        width = 0.5,
        height = 0.4,
        border = "single",
      },
      horizontal = { location = "rightbelow", split_ratio = 0.3 },
      vertical = { location = "rightbelow", split_ratio = 0.5 },
    },
  },
  behavior = {
    autoclose_on_quit = {
      enabled = false,
      confirm = true,
    },
    close_on_exit = true,
    auto_insert = true,
  },
})

local d_status, dc = pcall(require, "devcontainer")

if not d_status then
  return
end

dc.setup({
  -- config_search_start = function()
  --   -- By default this function uses vim.loop.cwd()
  --   -- This is used to find a starting point for .devcontainer.json file search
  --   -- Since by default, it is searched for recursively
  --   -- That behavior can also be disabled
  -- end,
  -- workspace_folder_provider = function()
  --   -- By default this function uses first workspace folder for integrated lsp if available and vim.loop.cwd() as a fallback
  --   -- This is used to replace `${localWorkspaceFolder}` in devcontainer.json
  --   -- Also used for creating default .devcontainer.json file
  -- end,
  -- terminal_handler = function(command)
  --   -- By default this function creates a terminal in a new tab using :terminal command
  --   -- It also removes statusline when that tab is active, to prevent double statusline
  --   -- It can be overridden to provide custom terminal handling
  -- end,
  nvim_dockerfile_template = function(base_image)
    -- Takes base_image and returns string, which should be used as a Dockerfile
    -- This is used when adding neovim to existing images
    -- Check out default implementation in lua/devcontainer/config.lua
    -- It installs neovim version based on current version
  end,
  devcontainer_json_template = function()
    -- Returns table - list of lines to set when creating new devcontainer.json files
    -- As a template
    -- Used only when using functions from commands module or created commands
  end,
  -- Can be set to false to prevent generating default commands
  -- Default commands are listed below
  generate_commands = true,
  -- By default no autocommands are generated
  -- This option can be used to configure automatic starting and cleaning of containers
  autocommands = {
    -- can be set to true to automatically start containers when devcontainer.json is available
    init = false,
    -- can be set to true to automatically remove any started containers and any built images when exiting vim
    clean = false,
    -- can be set to true to automatically restart containers when devcontainer.json file is updated
    update = false,
  },
  -- can be changed to increase or decrease logging from library
  log_level = "info",
  -- can be set to true to disable recursive search
  -- in that case only .devcontainer.json and .devcontainer/devcontainer.json files will be checked relative
  -- to the directory provided by config_search_start
  disable_recursive_config_search = false,
  -- By default all mounts are added (config, data and state)
  -- This can be changed to disable mounts or change their options
  -- This can be useful to mount local configuration
  -- And any other mounts when attaching to containers with this plugin
  attach_mounts = {
    -- Can be set to true to always mount items defined below
    -- And not only when directly attaching
    -- This can be useful if executing attach command separately
    always = false,
    neovim_config = {
      -- enables mounting local config to /root/.config/nvim in container
      enabled = false,
      -- makes mount readonly in container
      options = { "readonly" },
    },
    neovim_data = {
      -- enables mounting local data to /root/.local/share/nvim in container
      enabled = false,
      -- no options by default
      options = {},
    },
    -- Only useful if using neovim 0.8.0+
    neovim_state = {
      -- enables mounting local state to /root/.local/state/nvim in container
      enabled = false,
      -- no options by default
      options = {},
    },
    -- This takes a list of mounts (strings) that should always be added whenever attaching to containers
    -- This is passed directly as --mount option to docker command
    -- Or multiple --mount options if there are multiple values
    custom_mounts = {},
  },
  -- This takes a list of mounts (strings) that should always be added to every run container
  -- This is passed directly as --mount option to docker command
  -- Or multiple --mount options if there are multiple values
  always_mount = {},
})
