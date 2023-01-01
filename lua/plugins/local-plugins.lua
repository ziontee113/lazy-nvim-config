return {
    {
        dir = "~/.local/share/nvim/site/pack/packer/start/nvim-treehopper/",
        keys = {
            { "vm", mode = "n" },
        },
        config = function()
            local tree_hopper = require("tsht")

            tree_hopper.config.ft_to_parser.typescriptreact = "tsx"

            vim.keymap.set("n", "vm", function()
                tree_hopper.nodes()
            end, {})
        end,
    },
    {
        dir = "~/.config/nvim-custom-plugin/color-picker/",
        keys = {
            { "<C-c>", "<cmd>PickColor<cr>", mode = "n" },
            { "<C-c>", "<cmd>PickColorInsert<cr>", mode = "i" },
        },
        config = function()
            require("color-picker").setup({
                ["icons"] = { "ﱢ", "" },
                ["border"] = "rounded",
                ["keymap"] = {
                    ["Q"] = "<Plug>ColorPickerCloseColorPicker",
                    ["U"] = "<Plug>Slider5Decrease",
                    ["O"] = "<Plug>Slider5Increase",
                },
            })
        end,
    },
    {
        dir = "~/.config/nvim-custom-plugin/syntax-tree-surfer/",
        keys = {
            { "vu", mode = "n" },
            { "vd", mode = "n" },
            { "vU", mode = "n" },
            { "vD", mode = "n" },
            { "vn", mode = "n" },
            { "vx", mode = "n" },
            { "H", mode = "x" },
            { "J", mode = "x" },
            { "K", mode = "x" },
            { "L", mode = "x" },
        },
        config = function()
            require("syntax-tree-surfer")

            -- vx Swap
            vim.keymap.set("n", "vU", function()
                vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
                return "g@l"
            end, { silent = true, expr = true })
            vim.keymap.set("n", "vD", function()
                vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
                return "g@l"
            end, { silent = true, expr = true })

            -- vn Swap
            vim.keymap.set("n", "vu", function()
                vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
                return "g@l"
            end, { silent = true, expr = true })
            vim.keymap.set("n", "vd", function()
                vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
                return "g@l"
            end, { silent = true, expr = true })

            -- Visual Selection from Normal Mode
            vim.keymap.set("n", "vx", "<cmd>STSSelectMasterNode<cr>")
            vim.keymap.set("n", "vn", "<cmd>STSSelectCurrentNode<cr>")

            -- Select Nodes in Visual Mode
            vim.keymap.set("x", "J", "<cmd>STSSelectNextSiblingNode<cr>")
            vim.keymap.set("x", "K", "<cmd>STSSelectPrevSiblingNode<cr>")
            vim.keymap.set("x", "H", "<cmd>STSSelectParentNode<cr>")
            vim.keymap.set("x", "L", "<cmd>STSSelectChildNode<cr>")

            -- Swapping Nodes in Visual Mode
            vim.keymap.set("x", "<C-A-j>", "<cmd>STSSwapNextVisual<cr>")
            vim.keymap.set("x", "<C-A-k>", "<cmd>STSSwapPrevVisual<cr>")
        end,
    },
}
