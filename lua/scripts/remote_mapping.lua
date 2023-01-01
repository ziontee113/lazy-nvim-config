local feed_keys_utilities = require("scripts.feed_keys_utilities")
local feed = feed_keys_utilities.feed
local type_insert = feed_keys_utilities.type_insert

---------------------------------------------------------------------------------

USER_MAPPINGS = {}

local map = function(mode, mapping, callback, opts)
    vim.keymap.set(mode, mapping, callback, opts or {})

    local raw_mapping = mapping:gsub("<Plug>", "")

    if not vim.tbl_contains(USER_MAPPINGS, raw_mapping) then
        table.insert(USER_MAPPINGS, raw_mapping)
    end
end

---------------------------------------------------------------------------------

local pending_key_literal
local literal_emitter_mapping = "R1 M Down, L1 A Down"
map("i", "<Plug>" .. literal_emitter_mapping, function()
    if pending_key_literal then
        feed("<Plug>" .. pending_key_literal)
    end
end)

---------------------------------------------------------------------------------

map("n", "<Plug>L1 S Down, R1 O Down", ":so<cr>")

map("i", "<Plug>[L1 D Down, L1 F Down], R1 J Down", function()
    type_insert("ok man")
end)

map("n", "<Plug>L1 D Down, R1 J Down", function()
    feed("<cmd>Telescope help_tags<cr>")
end)

map("n", "<Plug>L1 S Down, R1 J Down", function()
    feed("<cmd>Telescope find_files<cr>")
end)

---------------------------------------------------------------------------------

local M = {}

M.handle_remote_input = function(input)
    if vim.tbl_contains(USER_MAPPINGS, input) then
        feed("<Plug>" .. input)
    end

    if input ~= literal_emitter_mapping then
        pending_key_literal = input
    end
end

return M
