return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "ThePrimeagen/harpoon",
        },
    },
    cmd = "Telescope",
    keys = {
        { "<leader>pp", desc = "Custom Paste Picker" },

        { "<A-Space>", desc = "Cycle Telescope Pickers" },

        { "<C-n>", "<cmd>Telescope notify<cr>", desc = "Telescope notify" },
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
        {
            "<leader>he",
            "<cmd>Telescope help_tags<cr>",
            desc = "Telescope help_tags",
        },
        {
            "-",
            "<cmd>Telescope help_tags<cr>",
            desc = "Telescope help_tags",
        },
        {
            "<leader>hi",
            "<cmd>Telescope highlights<cr>",
            desc = "Telescope highlights",
        },
        {
            "<C-0>",
            "<cmd>Telescope resume<cr>",
            desc = "Telescope resume",
        },
        {
            "<leader>of",
            "<cmd>Telescope oldfiles<cr>",
            desc = "Telescope oldfiles",
        },
        {
            "<leader>ke",
            "<cmd>Telescope keymaps<cr>",
            desc = "Telescope keymaps",
        },
    },
    config = function()
        require("custom-telescope-pickers")

        local telescope = require("telescope")
        local actions = require("telescope.actions")

        local builtin = require("telescope.builtin")

        local my_cycle_picker =
            require("special.cycle-telescope-pickers")(builtin.live_grep, builtin.find_files)

        vim.keymap.set("n", "<A-Space>", function()
            my_cycle_picker()
        end, {})

        telescope.setup({
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
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<A-Space>"] = function()
                            my_cycle_picker.next()
                        end,
                    },
                },
                -- sorters
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
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
                    initial_mode = "insert",
                    mappings = {
                        ["i"] = {
                            -- your custom insert mode mappings
                            ["<A-a>"] = telescope.extensions.file_browser.actions.create,
                            ["<C-t>"] = actions.file_tab,
                        },
                        ["n"] = {
                            -- your custom normal mode mappings
                        },
                    },
                },
            },
        })

        local extensions = { "undo", "file_browser", "notify" }
        for _, e in ipairs(extensions) do
            telescope.load_extension(e)
        end

        -- Testing custom pickers
        local paste_picker = require("custom-telescope-pickers.in-use.paste-picker")

        vim.keymap.set("n", "<leader>pp", function()
            paste_picker()
        end, {})
    end,
}
