---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: unused-local
local snippets, autosnippets = {}, {}
local luasnip_utils = require("special.luasnip-utils")
local cs = luasnip_utils.create_snippet

-------------------------------------------------------------------------

cs({
    trigger = "hello",
    nodes = fmt(
        [=[
hello {}
]=],
        {
            i(1, "world"),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j>h" },
})

cs({
    trigger = "range",
    nodes = fmt(
        [=[
start_row, start_col, end_row, end_col
]=],
        {}
    ),
    target_table = snippets,
})

-------------------------------------------------------------------------

return snippets, autosnippets
