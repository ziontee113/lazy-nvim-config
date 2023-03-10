return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground",
            "windwp/nvim-ts-autotag",
            "p00f/nvim-ts-rainbow",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        event = "BufReadPost",
        -- event = { "VeryLazy" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                sync_install = false,
                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                rainbow = {
                    enable = true,
                    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                },

                autotag = {
                    enable = true,
                },

                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["am"] = "@call.outer",
                            ["im"] = "@call.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["as"] = "@statement.outer",
                        },
                    },
                },

                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = true, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
            })
        end,
    },
}
