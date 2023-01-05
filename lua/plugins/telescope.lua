return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    cmd = "Telescope",
    keys = {
        -- Traditional Mappings
        { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
        { "<C-g>", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
        {
            "<C-f>",
            "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            desc = "Telescope current_buffer_fuzzy_find",
        },

        -- Remote Mappings
        {
            "<Plug>L1 E, R1 J<Plug>",
            "<cmd>Telescope find_files<cr>",
            desc = "Telescope find_files",
        },
        {
            "<Plug>L1 E, R1 H<Plug>",
            "<cmd>Telescope help_tags<cr>",
            desc = "Telescope help_tags",
        },
        {
            "<Plug>L1 E, R1 H, R1 I<Plug>",
            "<cmd>Telescope highlights<cr>",
            desc = "Telescope highlights",
        },
        {
            "<Plug>L1 E, L1 F<Plug>",
            "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            desc = "Telescope current_buffer_fuzzy_find",
        },
        {
            "<Plug>L1 E, L1 G<Plug>",
            "<cmd>Telescope live_grep<cr>",
            desc = "Telescope live_grep",
        },
        {
            "<Plug>L1 E, R1 O<Plug>",
            "<cmd>Telescope oldfiles<cr>",
            desc = "Telescope oldfiles",
        },
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                dynamic_preview_title = true,
                mappings = {
                    n = {
                        ["<Esc>"] = actions.close,
                    },
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-l>"] = actions.select_default,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                },
                lsp_dynamic_workspace_symbols = {
                    file_ignore_patterns = { "node_modules/" },
                },
            },
        })
    end,
}
