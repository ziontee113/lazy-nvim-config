return {
    "numToStr/Comment.nvim",
    keys = {
        { "gc", mode = "n" },
        { "gcc", mode = "n" },
        { "" },
    },
    config = function()
        require("Comment").setup()

        -- Comment
        vim.keymap.set("n", "", "gcc", { remap = true })
        vim.keymap.set("x", "", "gc", { remap = true })
    end,
}
