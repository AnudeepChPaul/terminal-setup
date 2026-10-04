return {
    "ThePrimeagen/refactoring.nvim",
    -- Pinned: later versions dropped refactor(), the debug table and the
    -- telescope extension that every mr* keymap depends on.
    commit = "74b608dfee827c2372250519d433cc21cb083407",
    -- No trigger: the mr* whichkey callbacks require("refactoring"), and lazy.nvim
    -- loads the plugin on that require. Loading on BufReadPre cost ~35ms per file.
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        prompt_func_return_type = {
            go = false,
            java = false,
            cpp = false,
            c = false,
            h = false,
            hpp = false,
            cxx = false,
        },
        prompt_func_param_type = {
            go = false,
            java = false,
            cpp = false,
            c = false,
            h = false,
            hpp = false,
            cxx = false,
        },
        printf_statements = {},
        print_var_statements = {},
        show_success_message = true, -- shows a message with information about the refactor on success
        -- i.e. [Refactor] Inlined 3 variable occurrences
    },
    config = function(_, opts)
        require("refactoring").setup(opts)
        require("telescope").load_extension("refactoring")
    end,
}
