-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")

-- get lualine nightfly theme
local lualine_nightfly = require("lualine.themes.nightfly")

--
-- -- change nightlfy theme colors
-- lualine_nightfly.normal.a.bg = new_colors.blue
-- lualine_nightfly.insert.a.bg = new_colors.green
-- lualine_nightfly.visual.a.bg = new_colors.violet
-- lualine_nightfly.command = {
--   a = {
--     gui = "bold",
--     bg = new_colors.yellow,
--     fg = new_colors.black, -- black
--   },
-- }
--
local Mode = {}

-- Color table for highlights
Mode.map = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["ntT"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

---@return string current mode name
function Mode.get_mode()
  local mode_code = vim.api.nvim_get_mode().mode
  if Mode.map[mode_code] == nil then
    return mode_code
  end
  return Mode.map[mode_code]
end

-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local mode_color = {
  n = colors.blue,
  i = colors.green,
  v = colors.red,
  V = colors.blue,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [""] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red,
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  function()
    return "▊ " .. Mode.get_mode() .. " ▊"
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
  -- filesize component
  "filesize",
  cond = conditions.buffer_not_empty,
})

ins_left({
  function()
    return vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  end,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = "bold" },
})

ins_left({
  color = { fg = colors.red, gui = "bold" },
  function()
    return (vim.bo.modified and "(M)" or "")
  end,
})

ins_left({
  function()
    return "%="
  end,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_right({
  -- Lsp server name .
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = " LSP:",
  color = { fg = "#ffffff" },
})
ins_right({ "location" })

ins_right({ "progress", color = { fg = colors.fg } })

ins_right({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.violet, gui = "bold" },
})

ins_right({
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = "柳 ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})
-- Add components to right sections
ins_right({
  "o:encoding", -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green },
})

ins_right({
  "fileformat",
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green },
})

ins_right({
  -- mode component
  function()
    return "▊"
  end,
  color = function()
    -- auto change color according to neovims mode

    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
})

-- Now don't forget to initialize lualine
lualine.setup(config)

--
--
-- -- configure lualine with modified theme
-- lualine.setup({
--   options = {
--     theme = lualine_nightfly,
--     icons_enabled = true,
--     component_separators = { left = "", right = "" },
--     section_separators = { left = "", right = "" },
--     always_divide_middle = true,
--     globalstatus = false,
--     refresh = {
--       statusline = 1000,
--       tabline = 1000,
--       winbar = 1000,
--     },
--   },
--   sections = {
--     lualine_a = { "buffers", mode = 2 },
--     lualine_b = { "branch", "diff", "diagnostics" },
--     lualine_c = { "filename" },
--     lualine_x = { "encoding", "fileformat", "filetype" },
--     lualine_y = { "progress" },
--     lualine_z = { "location" },
--   },
-- })