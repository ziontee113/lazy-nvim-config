---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: unused-local
local snippets, autosnippets = {}, {}
local luasnip_utils = require("special.luasnip-utils")
local cs = luasnip_utils.create_snippet

-------------------------------------------------------------------------

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
    trigger = "ass",
    nodes = fmt(
        [=[
assert.{}({}, {})
]=],
        {
            c(1, { t("equals"), t("same") }),
            i(2, "want"),
            i(3, "got"),
        }
    ),
    target_table = snippets,
})

cs({
    trigger = "sep",
    nodes = fmt(
        [=[

--------------------------------------------

]=],
        {}
    ),
    target_table = snippets,
})

cs({
    trigger = "before_each",
    nodes = fmt(
        [=[
    before_each(function()
        {}
    end)
]=],
        {
            i(1, "--"),
        }
    ),
    target_table = snippets,
})

cs({
    trigger = "buf_get_lines",
    nodes = fmt(
        [=[
vim.api.nvim_buf_get_lines({}, {}, {}, {})
]=],
        {
            i(1, "0"),
            i(2, "0"),
            i(3, "-1"),
            i(4, "false"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "clear_selected_text_and_enter_insert_mode",
    nodes = fmt(
        [=[
vim.api.nvim_input("<Del>")
vim.cmd("startinsert")
]=],
        {
            
        }
),
    target_table = snippets,
})

cs({
    trigger = "norm",
    nodes = fmt(
        [=[
vim.cmd("norm! {}")
]=],
        {
            i(1, "omg"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "get_node_text",
    nodes = fmt(
        [=[
vim.treesitter.get_node_text({}, {})
]=],
        {
            i(1, "node"),
            i(2, "0"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "cursor",
    nodes = fmt(
        [=[
vim.api.nvim_win_get_cursor({})
]=],
        {
            i(1, "0"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "update_selection",
    nodes = fmt(
        [=[
ts_utils.update_selection({}, {})
]=],
        {
            i(1, "0"),
            i(2, "node"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "ts_utils",
    nodes = fmt(
        [=[
{}
]=],
        {
            i(1, "local ts_utils = require(\"nvim-treesitter.ts_utils\")"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "schedule",
    nodes = fmt(
        [=[
vim.schedule(function ()
{}
end)
]=],
        {
            i(1, "   --   "),
        }
),
    target_table = snippets,
})

cs({
    trigger = "node:range",
    nodes = fmt(
        [=[
local start_row, start_col, end_row, end_col = node:range()
]=],
        {
            
        }
),
    target_table = snippets,
})

cs({
    trigger = "getchar",
    nodes = fmt(
        [=[
local ok, keynum = pcall(vim.fn.getchar)
if ok then
    local {} = string.char(keynum)

    {}
end
]=],
        {
            i(1, "key"),
            i(2, "-- TODO: do something with `key`"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "redraw",
    nodes = fmt(
        [=[
vim.cmd("redraw")
]=],
        {
            
        }
),
    target_table = snippets,
})

cs({
    trigger = "set_text",
    nodes = fmt(
        [=[
vim.api.nvim_buf_set_text({}, {}, {}, {}, {}, {{ {} }})
]=],
        {
            i(1, "0"),
            i(2, "30"),
            i(3, "1"),
            i(4, "30"),
            i(5, "5"),
            i(6, "sequence[2]"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "query_item",
    nodes = fmt(
        [=[
(({}) @cap)
]=],
        {
            i(1, "match_pattern"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "nvim_input",
    nodes = fmt(
        [=[
vim.api.nvim_input("{}")
]=],
        {
            i(1, "<BS>"),
        }
),
    target_table = snippets,
})

------------------------------------------------------------------------- Snippets goes here

return snippets, autosnippets
