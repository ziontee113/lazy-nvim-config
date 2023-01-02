return {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
        require("mini.ai").setup()
    end,
}
