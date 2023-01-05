return {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        local notify = require("notify")
        vim.notify = notify
        notify.setup({
            background_colour = "#000000",
            timeout = 2000,
        })
    end,
}
