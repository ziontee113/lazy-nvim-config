return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
        require("mini.ai").setup()
        require("mini.comment").setup({
            mappings = {
                textobject = "ic",
            },
        })

        vim.keymap.set("n", "", "gcc", { remap = true })
        vim.keymap.set("x", "", "gc", { remap = true })
    end,
}
