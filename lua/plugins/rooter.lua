return {
    "notjedi/nvim-rooter.lua",
    event = "VeryLazy",
    config = function()
        require("nvim-rooter").setup()
    end,
}
