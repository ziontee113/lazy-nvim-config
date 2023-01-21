return {
    {
        "echasnovski/mini.ai",
        config = function()
            require("mini.ai").setup()
        end,
    },
    {
        "echasnovski/mini.comment",
        keys = {
            { mode = "n", "gc" },
            { mode = "x", "gc" },
            { mode = "n", "", "gcc", remap = true },
            { mode = "x", "", "gc", remap = true },
            { mode = "n", "<C-/>", "gcc", remap = true },
            { mode = "x", "<C-/>", "gc", remap = true },
        },
        config = function()
            require("mini.comment").setup({
                mappings = {
                    textobject = "ic",
                },
            })
        end,
    },
}
