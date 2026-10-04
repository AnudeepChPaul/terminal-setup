-- lualine has no "relative to project root" path mode, so render the absolute
-- path (path = 2) and rewrite the prefix in fmt.
--
-- Only the expensive part (root detection + reading package.json) is cached; the
-- width-dependent shortening is recomputed each draw so it reacts to resizes
-- without ever touching the filesystem again.
local project_path_cache = {}

-- Columns to leave for everything else on the statusline: mode, branch, diff,
-- diagnostics, LSP name, encoding, fileformat, progress, location, filesize.
local RESERVED_COLUMNS = 78

local function project_parts()
    local abs = vim.fn.expand("%:p")
    if abs == "" then
        return nil
    end

    local cached = project_path_cache[abs]
    if cached then
        return cached
    end

    local parts
    local git_root = vim.fs.root(abs, ".git")
    if not git_root then
        parts = {prefix = "", rel = vim.fn.expand("%:t")}
    else
        local pkg_dir = vim.fs.root(abs, "package.json")
        local in_subpackage = pkg_dir ~= nil
            and pkg_dir ~= git_root
            and vim.fs.relpath(git_root, pkg_dir) ~= nil

        if in_subpackage then
            local name
            local ok, decoded = pcall(function()
                return vim.json.decode(table.concat(vim.fn.readfile(pkg_dir .. "/package.json"), "\n"))
            end)
            if ok and type(decoded) == "table" and type(decoded.name) == "string" then
                name = decoded.name
            end
            parts = {
                prefix = string.format("[%s] ", name or vim.fs.basename(pkg_dir)),
                rel = vim.fs.relpath(pkg_dir, abs),
            }
        else
            parts = {prefix = "", rel = vim.fs.relpath(git_root, abs) or vim.fn.expand("%:t")}
        end
    end

    project_path_cache[abs] = parts
    return parts
end

local function project_display_path()
    local parts = project_parts()
    if not parts then
        return nil
    end

    local available = vim.fn.winwidth(0) - RESERVED_COLUMNS
    local candidates = {
        parts.prefix .. parts.rel,
        -- directory initials, full filename: s/a/a/T/OverviewPage.tsx
        parts.prefix .. vim.fn.pathshorten(parts.rel),
        parts.prefix .. vim.fs.basename(parts.rel),
        vim.fs.basename(parts.rel),
    }
    for _, candidate in ipairs(candidates) do
        if #candidate <= available then
            return candidate
        end
    end
    return candidates[#candidates]
end

local filename_component = {
    "filename",
    file_status = true,
    newfile_status = true,
    path = 2, -- absolute, so fmt gets an exact prefix to replace
    shorting_target = 0, -- shortening runs before fmt and would break the match
    symbols = {
        modified = "~",
        readonly = "[-]",
        unnamed = "[Untitled]",
        newfile = "[New]",
    },
    fmt = function(str)
        local display = project_display_path()
        if not display then
            return str
        end
        local abs = vim.fn.expand("%:p")
        return (str:gsub("^" .. vim.pesc(abs), (display:gsub("%%", "%%%%")), 1))
    end,
}

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        return {
            options = {
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { statusline = { "neo-tree", "toggleterm", "fugitive" } },
                always_divide_middle = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    "mode",
                    "branch",
                },
                lualine_b = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    filename_component,
                },
                lualine_c = {
                    "diff",
                },
                lualine_x = {
                    "searchcount",
                    "selectioncount",
                    {
                        "diagnostics",
                        sources = { "nvim_lsp" },
                    },
                },
                lualine_y = {
                    function()
                        local a = ""
                        local msg = "No Active Lsp"
                        local buf_ft = vim.bo.filetype
                        local clients = vim.lsp.get_clients()
                        local icon = " LSP: "
                        if next(clients) == nil then
                            return icon .. msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return icon .. client.name
                            end
                        end
                        return icon .. msg
                    end,
                    "encoding",
                    "fileformat",
                },
                lualine_z = { "progress", "location", "filesize" },
            },
            inactive_sections = {
                lualine_c = { filename_component },
                lualine_x = { "location" },
            },
            extensions = { "fugitive" },
        }
    end,
}
