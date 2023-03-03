return {
    {
        "ziontee113/SelectEase",
        config = function()
            local select_ease = require("SelectEase")

            local lua_query = [[
                ;; query
                ((identifier) @cap)
                ("string_content" @cap)
                ((true) @cap)
                ((false) @cap)
            ]]
            local python_query = [[
                ;; query
                ((identifier) @cap)
                ((string) @cap)
            ]]
            local tsx_query = [[
                ;; query
                ((identifier) @cap)
                ((string_fragment) @cap)
                ((property_identifier) @cap)
            ]]
            local rust_query = [[
                ;; query
                ((identifier) @cap)
                ((field_identifier) @cap)
                ((string_literal) @cap)
                ((integer_literal) @cap)
                ((match_pattern) @cap)
            ]]

            local queries = {
                lua = lua_query,
                python = python_query,
                tsx = tsx_query,
                rust = rust_query,
            }

            -- Jump and Select
            vim.keymap.set({ "n", "s", "i" }, "<C-A-k>", function()
                select_ease.select_node({
                    queries = queries,
                    direction = "previous",
                    -- visual_mode = true,
                    vertical_drill_jump = true,
                    fallback = function()
                        select_ease.select_node({ queries = queries, direction = "previous" })
                    end,
                })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-j>", function()
                select_ease.select_node({
                    queries = queries,
                    direction = "next",
                    -- visual_mode = true,
                    vertical_drill_jump = true,
                    fallback = function()
                        select_ease.select_node({ queries = queries, direction = "next" })
                    end,
                })
            end, {})

            vim.keymap.set({ "n", "s", "i" }, "<C-A-h>", function()
                select_ease.select_node({
                    queries = queries,
                    direction = "previous",
                    current_line_only = true,
                    fallback = function()
                        select_ease.select_node({ queries = queries, direction = "previous" })
                    end,
                })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-l>", function()
                select_ease.select_node({
                    queries = queries,
                    direction = "next",
                    current_line_only = true,
                    fallback = function()
                        select_ease.select_node({ queries = queries, direction = "next" })
                    end,
                })
            end, {})

            vim.keymap.set({ "n", "s", "i" }, "<C-A-p>", function()
                select_ease.select_node({ queries = queries, direction = "previous" })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-n>", function()
                select_ease.select_node({ queries = queries, direction = "next" })
            end, {})

            -- Swap Nodes
            vim.keymap.set({ "n", "s", "i" }, "<C-A-S-k>", function()
                select_ease.swap_nodes({
                    queries = queries,
                    direction = "previous",
                    vertical_drill_jump = true,

                    -- swap_in_place option. Default behavior is cursor will jump to target after the swap
                    -- jump_to_target_after_swap = false --> this will keep cursor in place after the swap
                })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-S-j>", function()
                select_ease.swap_nodes({
                    queries = queries,
                    direction = "next",
                    vertical_drill_jump = true,
                })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-S-h>", function()
                select_ease.swap_nodes({
                    queries = queries,
                    direction = "previous",
                    current_line_only = true,
                })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-S-l>", function()
                select_ease.swap_nodes({
                    queries = queries,
                    direction = "next",
                    current_line_only = true,
                })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-S-p>", function()
                select_ease.swap_nodes({ queries = queries, direction = "previous" })
            end, {})
            vim.keymap.set({ "n", "s", "i" }, "<C-A-S-n>", function()
                select_ease.swap_nodes({ queries = queries, direction = "next" })
            end, {})
        end,
    },
    {
        "ziontee113/SnippetGenie",
        config = function()
            local genie = require("SnippetGenie")

            genie.setup({
                snippet_skeleton = [[
cs({{
    trigger = "{trigger}",
    nodes = fmt(
        [=[
{body}
]=],
        {{
            {nodes}
        }}
),
    target_table = snippets,
}})
]],
            })

            -- keymaps
            vim.keymap.set("x", "<CR>", function()
                genie.create_new_snippet_or_add_placeholder()
                vim.cmd("norm! ") -- exit Visual Mode, go back to Normal Mode
            end, {})

            vim.keymap.set("n", "<CR>", function()
                genie.finalize_snippet()
            end, {})
        end,
    },
    {
        "ziontee113/query-secretary",
        keys = { "<leader><BS>" },
        config = function()
            require("query-secretary").setup({
                open_win_opts = {
                    row = 0,
                    col = 9999,
                    width = 50,
                    height = 15,
                },

                -- other options you can customize
                buf_set_opts = {
                    tabstop = 2,
                    softtabstop = 2,
                    shiftwidth = 2,
                },

                capture_group_names = { "cap", "second", "third" }, -- when press "c"
                predicates = { "eq", "any-of", "contains", "match", "lua-match" }, -- when press "p"
                visual_hl_group = "Visual", -- when moving cursor around

                -- here are the default keymaps
                keymaps = {
                    close = { "q", "Esc" },
                    next_predicate = { "p" },
                    previous_predicate = { "P" },
                    remove_predicate = { "d" },
                    toggle_field_name = { "f" },
                    yank_query = { "y" },
                    next_capture_group = { "c" },
                    previous_capture_group = { "C" },
                },
            })

            vim.keymap.set("n", "<leader><BS>", function()
                require("query-secretary").query_window_initiate()
            end, {})
        end,
    },
    {
        "ziontee113/icon-picker.nvim",
        keys = {
            { mode = "i", "<A-i>" },
            { mode = "n", "<Leader><Leader>i" },
        },
        config = function()
            require("icon-picker").setup({
                disable_legacy_commands = true,
            })
            vim.keymap.set("i", "<A-i>", "<cmd>IconPickerInsert<cr>", {})
            vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", {})
        end,
    },
    {
        "ziontee113/neo-minimap",
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
                    [[
                        ;; query
                        (((attribute_item) @attr (function_item) @cap (#vim-match? @attr "test")))
                    ]],
                    2,
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
                        ((identifier) @cap (#any-of? @cap "describe" "it"))
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
        "mfussenegger/nvim-treehopper",
        keys = {
            { "vm", mode = "n" },
        },
        config = function()
            local tree_hopper = require("tsht")

            vim.keymap.set("n", "vm", function()
                tree_hopper.nodes()
            end, {})
        end,
    },
    {
        "ziontee113/color-picker.nvim",
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
        "ziontee113/syntax-tree-surfer",
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
