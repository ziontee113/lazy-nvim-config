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

------------------------------------------------------------------------- Snippets goes here

return snippets, autosnippets
