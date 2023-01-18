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
    trigger = "ref",
    nodes = fmt(
        [=[
---REFACTOR:
]=],
        {
            
        }
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

-------------------------------------------------------------------------

return snippets, autosnippets
