return {
    "anuvyklack/windows.nvim",
    event = "VeryLazy",
    dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim",
    },
    config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false

        require("windows").setup()

        vim.keymap.set("n", "<C-z>", ":WindowsMaximize<cr>")
        vim.keymap.set("n", "<C-w>_", ":WindowsMaximizeVertically<cr>")
        vim.keymap.set("n", "<C-w>|", ":WindowsMaximizeHorizontally<cr>")
        vim.keymap.set("n", "<C-w>=", ":WindowsEqualize<cr>")
    end,
}
