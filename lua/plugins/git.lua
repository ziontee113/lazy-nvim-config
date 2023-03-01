return {
    {
        "tpope/vim-fugitive",
        cmd = { "G", "GBrowse" },
        keys = {
            { "<C-9>", "<cmd>G<cr>" },
            { "gl", "<cmd>G log<cr>" },
            "<leader>gc",
            "<leader>ga",
        },
        dependencies = {
            "tpope/vim-rhubarb",
        },
        config = function()
            local function fugitive_mapping(mapping, cmd)
                vim.keymap.set("n", mapping, function()
                    local old_height = vim.o.cmdheight
                    vim.o.cmdheight = 1
                    vim.cmd(cmd)
                    vim.o.cmdheight = old_height
                end, {})
            end

            fugitive_mapping("<leader>gc", "G commit")
            fugitive_mapping("<leader>ga", "G add .")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        -- event = "VeryLazy",
        event = "BufReadPost",
        config = function()
            local choice = "▎"
            -- local choice = "│"

            require("gitsigns").setup({
                signs = {
                    add = {
                        hl = "GitSignsAdd",
                        text = choice,
                        numhl = "GitSignsAddNr",
                        linehl = "GitSignsAddLn",
                    },
                    change = {
                        hl = "GitSignsChange",
                        text = choice,
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    delete = {
                        hl = "GitSignsDelete",
                        text = "_",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    topdelete = {
                        hl = "GitSignsDelete",
                        text = "‾",
                        numhl = "GitSignsDeleteNr",
                        linehl = "GitSignsDeleteLn",
                    },
                    changedelete = {
                        hl = "GitSignsChange",
                        text = "~",
                        numhl = "GitSignsChangeNr",
                        linehl = "GitSignsChangeLn",
                    },
                    untracked = {
                        hl = "GitSignsAdd",
                        text = "┆",
                        numhl = "GitSignsAddNr",
                        linehl = "GitSignsAddLn",
                    },
                },
            })
        end,
    },
}
