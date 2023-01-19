---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: unused-local
local snippets, autosnippets = {}, {}
local luasnip_utils = require("special.luasnip-utils")
local cs = luasnip_utils.create_snippet

-------------------------------------------------------------------------

cs({
    trigger = {
        trig = "hello",
        priority = 200,
        docstring = "what the fuck",
    },
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

cs({
    trigger = "input",
    nodes = fmt(
        [=[
{}.{}.{}({{
    {} = "{}",
}}, function({})
    -- TODO:
end)
]=],
        {
            i(1, "vim"),
            i(2, "ui"),
            i(3, "input"),
            i(4, "prompt"),
            i(5, "Input Prompt"),
            i(6, "input"),
        }
    ),
    target_table = snippets,
})

cs({
    trigger = "args",
    nodes = fmt(
        [=[
local {} = {{
    {} = {},
    {} = {},
    {} = {}.{}({}, "{}"),
}}
]=],
        {
            i(1, "args"),
            i(2, "trigger"),
            i(3, "trigger"),
            i(4, "body"),
            i(5, "body_text"),
            i(6, "nodes"),
            i(7, "table"),
            i(8, "concat"),
            i(9, "insert_nodes"),
            i(10, "\\n"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "highlight",
    nodes = fmt(
        [=[
{}.{}.{}(
    0,
    {},
    {},
    {{ {} - 1, {} - 1 }},
    {{ {} - 1, {} }},
    {{ {} = 1000 }}
)
]=],
        {
            i(1, "vim"),
            i(2, "highlight"),
            i(3, "range"),
            i(4, "ns"),
            i(5, "hl_group"),
            i(6, "start_row"),
            i(7, "start_col"),
            i(8, "end_row"),
            i(9, "end_col"),
            i(10, "priority"),
        }
),
    target_table = snippets,
})

-------------------------------------------------------------------------

return snippets, autosnippets
