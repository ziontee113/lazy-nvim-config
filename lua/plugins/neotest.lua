return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rouge8/neotest-rust",
        "nvim-neotest/neotest-plenary",
    },
    keys = {
        { "tu", mode = "n" },
        { "tt", mode = "n" },
        { "TT", mode = "n" },
        { "TS", mode = "n" },
    },
    config = function()
        local neotest = require("neotest")

        neotest.setup({
            adapters = {
                require("neotest-rust")({
                    args = { "--no-capture" },
                }),
                require("neotest-plenary"),
            },
            quickfix = {
                enabled = false,
                open = false,
            },
        })

        -- Mappings
        vim.keymap.set("n", "tu", function()
            neotest.run.run() -- current test
        end, {})

        vim.keymap.set("n", "tt", function()
            require("neotest").run.run(vim.fn.expand("%")) -- current file
        end, {})

        vim.keymap.set("n", "to", function()
            neotest.output.open({ enter = true, short = true }) -- output window
        end, {})

        vim.keymap.set("n", "TT", function()
            require("neotest").run.run(vim.fn.expand("%:p:h:h")) -- entire test folder
        end, {})

        vim.keymap.set("n", "TS", function()
            require("neotest").summary.toggle() -- summary tree
        end, {})
    end,
}
