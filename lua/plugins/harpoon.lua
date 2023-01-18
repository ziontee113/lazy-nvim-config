return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        "<leader>ha",
        "<Tab>",
        "[[",
        "]]",
        "[]",
        "][",
    },
    config = function()
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>ha", function()
            require("harpoon.mark").add_file()
        end, {})
        vim.keymap.set("n", "<Tab>", function()
            ui.toggle_quick_menu()
        end, {})

        vim.keymap.set("n", "[[", function()
            ui.nav_file(1)
        end, {})
        vim.keymap.set("n", "]]", function()
            ui.nav_file(2)
        end, {})
        vim.keymap.set("n", "[]", function()
            ui.nav_file(3)
        end, {})
        vim.keymap.set("n", "][", function()
            ui.nav_file(4)
        end, {})
    end,
}
