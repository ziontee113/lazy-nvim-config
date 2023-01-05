return {
    {
        dir = "~/.config/nvim-custom-plugin/neo-minimap/",
        event = "VeryLazy",
        config = function()
            local nm = require("neo-minimap")

            nm.setup_defaults({
                -- height_toggle = { 12, 25 },
                height_toggle = { 20, 25 },
                hl_group = "DiagnosticWarn",
            })

            -- Rust

            nm.set({ "zi", "zo" }, "*.rs", {
                events = { "BufEnter" },
                query = {
                    [[
                        ;; query
                        (enum_item (type_identifier) @cap)
                        (trait_item (type_identifier) @cap)
                        (struct_item (type_identifier) @cap)
                        ;; (impl_item (type_identifier) @cap)
                        ((impl_item) @cap)
                        (function_item (identifier) @cap)
                        (mod_item (identifier) @cap)
                        (macro_definition (identifier) @cap)
                        ]],
                    1,
                },
                regex = {},
                search_patterns = {
                    { "impl", "<C-j>", true },
                    { "impl", "<C-k>", false },
                    { "mod", "<C-l>", false },
                },
                height_toggle = { 20, 25 },
            })

            -- Latex

            nm.set({ "zo", "zu" }, "*.tex", {
                events = { "BufEnter" },
                query = {},
                regex = {
                    { [[\\section]], [[\\subsection]], [[\\subsubsection]] },
                    { [[\\begin{.*}]] },
                },
            })

            -- Lua
            nm.set({ "zi", "zo", "zu" }, "*.lua", {
                events = { "BufEnter", "BufReadPost" },

                query = {
                    [[
                        ;; query
                        ;; ((function_declaration name: ((identifier) @name (#eq? @name "{cursorword}"))) @cap)
                        ;; ((function_call name: ((identifier) @name (#eq? @name "{cursorword}"))) @cap)
                        ;; ((dot_index_expression field: ((identifier) @name (#eq? @name "{cursorword}"))) @cap)
                        ((function_declaration) @cap)
                        ((assignment_statement(expression_list((function_definition) @cap))))
                    ]],
                    1,
                    [[
                        ;; query
                        ((function_declaration) @cap)
                        ((assignment_statement(expression_list((function_definition) @cap))))
                        ((field (identifier) @cap) (#eq? @cap "keymaps"))
                    ]],
                    [[
                        ;; query
                        ((for_statement) @cap)
                        ((function_declaration) @cap)
                        ((assignment_statement(expression_list((function_definition) @cap))))
                        ((function_call (identifier)) @cap (#vim-match? @cap "^__*" ))
                        ((function_call (dot_index_expression) @field (#eq? @field "vim.keymap.set")) @cap)
                    ]],
                    [[
                        ;; query
                        ((for_statement) @cap)
                        ((function_declaration) @cap)
                        ((assignment_statement(expression_list((function_definition) @cap))))
                    ]],
                },

                regex = {
                    {},
                    { [[^\s*---*\s\+\w\+]], [[--\s*=]] },
                    { [[^\s*---*\s\+\w\+]], [[--\s*=]] },
                    {},
                },

                search_patterns = {
                    { "function", "<C-j>", true },
                    { "function", "<C-k>", false },
                    { "keymap", "<A-j>", true },
                    { "keymap", "<A-k>", false },
                },

                -- auto_jump = false,
                -- open_win_opts = { border = "double" },
                win_opts = { scrolloff = 1 },

                disable_indentaion = true,
            })

            -- Typescript React
            nm.set("zi", { "typescriptreact", "javascriptreact" }, {
                query = [[
                    ;; query
                    ((function_declaration) @cap)
                    ((arrow_function) @cap)
                    ((identifier) @cap (#vim-match? @cap "^use.*"))
                ]],
            })
        end,
    },
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
