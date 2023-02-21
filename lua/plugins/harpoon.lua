return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    -- TODO: rethink the way we use `ui.nav_file`, since pressing <Tab> then `l` feels so much quicker
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
    end,
}
