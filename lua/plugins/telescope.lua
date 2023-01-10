return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
    },
    cmd = "Telescope",
    keys = {
        { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
        { "<C-g>", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
        {
            "<C-f>",
            "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            desc = "Telescope current_buffer_fuzzy_find",
        },
        {
            "<C-;>",
            "<cmd>Telescope file_browser<cr>",
            desc = "Telescope file_browser",
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
                        ["<Esc>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-l>"] = actions.select_default,
                    },
                },
                -- copied from https://github.com/NvChad/NvChad/blob/main/lua/plugins/configs/telescope.lua
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                -- thicker borders
                winblend = 0,
                border = {},
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
            pickers = {
                find_files = {
                    find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
                },
                lsp_dynamic_workspace_symbols = {
                    file_ignore_patterns = { "node_modules/" },
                },
            },
            extensions = {
                undo = {
                    -- telescope-undo.nvim config, see below
                },
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                            -- your custom insert mode mappings
                        },
                        ["n"] = {
                            -- your custom normal mode mappings
                        },
                    },
                },
            },
        })

        local extensions = { "undo", "file_browser" }
        for _, e in ipairs(extensions) do
            require("telescope").load_extension(e)
        end
    end,
}
