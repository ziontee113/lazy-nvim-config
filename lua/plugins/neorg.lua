return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers", -- This is the important bit!
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.norg.concealer"] = {},
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true,
                        neorg_leader = ",",
                        hook = function(keybinds)
                            keybinds.unmap("all", "n", "<c-s>")
                        end,
                    },
                },
            },
        })
    end,
}
