vim.keymap.set("n", "<C-9>", "<cmd>G<cr>")
vim.keymap.set("n", "gl", "<cmd>G log<cr>")

return {
    {
        "tpope/vim-fugitive",
        cmd = { "G", "GBrowse" },
        dependencies = {
            "tpope/vim-rhubarb",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
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
