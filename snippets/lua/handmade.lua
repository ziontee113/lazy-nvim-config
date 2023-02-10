---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: unused-local
local snippets, autosnippets = {}, {}
local luasnip_utils = require("special.luasnip-utils")
local cs = luasnip_utils.create_snippet
local tsn = luasnip_utils.tsn
local pattern = "*.lua"

-- QUESTION: what about variations of a choice?

------------------------- Others

cs({
    trigger = "locM",
    nodes = fmt(
        [=[
local M = {{}}

{}

return M
]=],
        {
            i(1, ""),
        }
    ),
    target_table = snippets,
})

cs({
    trigger = "selectionRange",
    nodes = fmt(
        [=[
local start_row, start_col = vim.fn.line("v"), vim.fn.col("v")
local end_row, end_col = vim.fn.line("."), vim.fn.col(".")
]=],
        {}
    ),
    target_table = snippets,
})

-- ==== Testing tn (Treesitter Node) ==== --
cs({
    trigger = "_trigger",
    nodes = fmt(
        [=[
just testing {}
]=],
        {
            tsn(1, { lang = "lua", query_file = "super_idol", capture_name = "cap1" }),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-t>t" },
})

-- ==== Plenary Testing ==== --

-- describe
cs({
    trigger = "describe",
    nodes = fmt(
        [=[
describe("{}", function()
    it("{}", function()
        {}
    end)
end)
]=],
        {
            i(1, ""),
            i(2, ""),
            i(3, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*_spec.lua" },
    keymaps = { "<C-k><C-k>" },
})

cs({
    trigger = "it",
    nodes = fmt(
        [=[
it("{}", function()
    {}
end)
]=],
        {
            i(1, ""),
            i(2, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*_spec.lua" },
    keymaps = { "<C-j><C-k>" },
})

-- ==== Comments ==== --
cs({
    trigger = "todo",
    nodes = fmt(
        [=[
-- {}: {}
]=],
        {
            c(1, { t(""), t("TODO"), t("ANSWER"), t("FIX"), t("HACK"), t("BUG"), t("QUESTION") }),
            i(2, ""),
        }
    ),
    target_table = snippets,
    pattern = { pattern },
    keymaps = { "<a-,>" },
})

-- ==== Lua ==== --

-- for loop
cs({
    trigger = "for",
    nodes = fmt(
        [=[
for {}, {} in {}({}) do
    {}
end
]=],
        {
            i(1, "index"),
            i(2, "value"),
            c(3, { t("ipairs"), t("pair") }),
            i(4, "table"),
            i(5, "-- TODO:"),
        }
    ),
    target_table = snippets,
    pattern = { pattern },
    keymaps = { "<C-f>o" },
})

-- vim.inspect()

cs({
    trigger = "_trigger",
    nodes = fmt(
        [=[
print(vim.inspect({}))
]=],
        {
            i(1, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j>p" },
})

-- print()
cs({
    trigger = "_trigger",
    nodes = fmt(
        [=[
print({})
]=],
        {
            i(1, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j><C-p>" },
})

-- table.insert
cs({
    trigger = "tabi",
    nodes = fmt(
        [=[
table.insert({}, {})
]=],
        {
            i(1, "tbl"),
            i(2, "item"),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-t>i" },
})

-- blank function
cs({
    trigger = "_trigger",
    nodes = fmt(
        [=[
function {}({})
    {}
end
]=],
        {
            i(1, "myfunc"),
            i(2, ""),
            i(3, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j>f" },
})

-- local function
cs({
    trigger = "lof",
    nodes = fmt(
        [=[
local {} = function({})
    {}
end
]=],
        {
            i(1, "myfunc"),
            i(2, ""),
            i(3, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-l>f" },
})

-- M. function
cs({
    trigger = "mfu",
    nodes = fmt(
        [=[
M.{} = function({})
    {}
end
]=],
        {
            i(1, "myfunc"),
            i(2, ""),
            i(3, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-k>f" },
})

-- require
cs({
    trigger = "require",
    nodes = fmt(
        [=[
require("{}")
]=],
        {
            i(1, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j>r" },
})

-- local & require
cs({
    trigger = "loc",
    nodes = fmt(
        [=[
local {} = {}
]=],
        {
            i(1, ""),
            c(2, { i(1, ""), fmt([=[require("{}")]=], { i(1, "") }) }),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-J><C-L>", "<C-L><C-L>" },
})

-- <C-?> shortcut
cs({
    trigger = "<",
    nodes = fmt(
        [=[
<C-{}>
]=],
        {
            i(1, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-L><C-C>" },
})

-- Augroup
cs({
    trigger = "augroup",
    nodes = fmt(
        [=[
local {} = vim.api.nvim_create_augroup("{}", {{ clear = true }})
]=],
        {
            i(1, "augroup"),
            i(2, "Augroup Name"),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-J>au" },
})

-- Autocmd
cs({
    trigger = "autocmd",
    nodes = fmt(
        [=[
vim.api.nvim_create_autocmd({{ "{}" }}, {{
	pattern = "{}",
	group = {},
	callback = function()
        {}
	end,
}})
]=],
        {
            i(1, "Event"),
            i(2, "*"),
            i(3, "augroup"),
            i(4, "-- TODO:"),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-J>ac" },
})

-- Execute On Save
cs({
    trigger = "onsave",
    nodes = fmt(
        [=[
-- {{{nvim-execute-on-save}}}
]=],
        {},
        { delimiters = "<>" }
    ),
    target_table = snippets,
    pattern = { "*/.config/*.lua" },
    keymaps = { "<C-j><C-o><C-s>" },
})

-- N() for Notify
cs({
    trigger = "_trigger",
    nodes = fmt(
        [=[
N({})
]=],
        {
            c(1, { fmt([["{}"]], i(1, "")), fmt([[{{{}}}]], i(1, "")), i(1, "") }),
        }
    ),
    target_table = snippets,
    pattern = { "*/.config/*.lua" },
    keymaps = { "<C-j><C-n>" },
})

-- vim.api.nvim_buf_set_extmark
cs({
    trigger = "extmark",
    nodes = fmt(
        [=[
vim.api.nvim_buf_set_extmark({}, {}, {}, {}, {{
    virt_text = {{ {{ "{}", "{}" }} }},
    virt_text_pos = "{}",
}})
]=],
        {
            i(1, "0"),
            i(2, "ns"),
            i(3, "line"),
            i(4, "col"),
            i(5, "text"),
            i(6, "Normal"),
            i(7, "overlay"),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j><C-x>" },
})

-- vim.api.nvim_buf_clear_namespace
cs({
    trigger = "clear_namespace",
    nodes = fmt(
        [=[
vim.api.nvim_buf_clear_namespace({}, {}, {}, {})
]=],
        {
            i(1, "0"),
            i(2, "ns"),
            i(3, "0"),
            i(4, "-1"),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-k>ns" },
})

-- vim.api.nvim_buf_create_namespace
cs({
    trigger = "namespace",
    nodes = fmt(
        [=[
local {} = vim.api.nvim_create_namespace("{}")
]=],
        {
            i(1, "ns"),
            i(2, "namespace_name"),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j>ns" },
})

-- Add Remote Mapping
cs({
    trigger = "_trigger",
    nodes = fmt(
        [=[
REMAP("{}", "{}", {})
]=],
        {
            c(1, { i(1, "n"), i(1, "x") }),
            i(2, ""),
            c(3, {
                fmt([["{}"]], i(1, "")),
                fmt(
                    [[
function()
    {}
end
            ]],
                    i(1, "")
                ),
            }),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-k><C-m>" },
})

-- vim.keymap.set
cs({
    trigger = "vim.keymap.set",
    nodes = fmt(
        [=[
vim.keymap.set("{}", "{}", {}, {{{}}})
]=],
        {
            c(1, { i(1, "n"), i(1, "x") }),
            i(2, ""),
            c(3, {
                fmt(
                    [[
function()
    {}
end
            ]],
                    i(1, "")
                ),
                fmt([["{}"]], i(1, "")),
            }),
            c(4, { i(1, ""), fmt([[ buffer = {} ]], { i(1, "buf") }, { dedent = false }) }),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-k><C-s>" },
})

-- vim.api
cs({
    trigger = "api",
    nodes = fmt(
        [=[
{}
]=],
        {
            c(1, {
                t("vim.api."),
                fmt([[vim.api.nvim_buf_{}({})]], { i(1, ""), i(2, "") }),
                fmt([[vim.api.nvim_win_{}({})]], { i(1, ""), i(2, "") }),
            }),
        }
    ),
    target_table = snippets,
    pattern = { "*.lua" },
    keymaps = { "<C-j><C-a>" },
})

-- ==== LuaSnip ==== --

-- LuaSnip fmt
cs({
    trigger = "fmt",
    nodes = fmt(
        [==[
{}fmt([=[
{}
]=], {{
    {}
}})
]==],
        {
            c(1, { i(1, ""), fmt([[local {} = ]], i(1, "")) }),
            i(2, ""),
            i(3, ""),
        }
    ),
    target_table = snippets,
    pattern = { "snippets/*.lua" },
    keymaps = { "<C-h>f" },
})

-- LuaSnip Snippet Node
cs({
    trigger = "snippet_node",
    nodes = fmt(
        [=[
sn({}, {{{}}})
]=],
        {
            i(1, "1"),
            i(2, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*/snippets/*.lua" },
    keymaps = { "<C-K>sn" },
})

-- LuaSnip Insert Node
cs({
    trigger = "insert_node",
    nodes = fmt(
        [=[
i(1, "{}"),
]=],
        {
            i(1, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*/snippets/*.lua" },
    keymaps = { "<C-j><C-k>" },
})

-- LuaSnip Choice Node
cs({
    trigger = "choice_node",
    nodes = fmt(
        [=[
c({}, {{ {} }}),
]=],
        {
            i(1, ""),
            i(2, ""),
        }
    ),
    target_table = snippets,
    pattern = { "*/snippets/*.lua" },
    keymaps = { "<C-k><C-c>" },
})

-- Create Lua Snippet
local createLuaSnippet_keymaps_fmt = fmt(
    [[
{}target_table = {},
    pattern = {{ {} }},
    keymaps = {{ "{}" }},
  ]],
    {
        i(1, ""),
        c(2, { t("snippets"), t("autosnippets") }),
        c(3, { i(1, "pattern"), sn(1, { t('*."'), i(1, '"') }) }),
        i(4, ""),
    }
)

local createLuaSnippet_fmt = fmt(
    [[
cs({{
	trigger = "{}",
	nodes = fmt(
    [=[
{}
]=],
    {{
      {}
    }}
  ),
  {}
}})
]],
    {
        i(3, "_trigger"),
        i(1, ""),
        i(2, ""),
        c(4, {
            t("target_table = snippets"),
            t("target_table = autosnippets"),
            createLuaSnippet_keymaps_fmt,
        }),
    }
)

cs({
    trigger = "createLuaSnippet",
    nodes = createLuaSnippet_fmt,
    target_table = snippets,
    pattern = { "*/snippets/*.lua" },
    keymaps = { "<C-K>c", "<C-J>cs" },
})

return snippets, autosnippets
