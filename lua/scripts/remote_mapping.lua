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
local literal_emitter_mapping = "R1 M, L1 A"
map("i", "<Plug>" .. literal_emitter_mapping, function()
    if pending_key_literal then
        feed("<Plug>" .. pending_key_literal)
    end
end)

--------------------------------------------------------------------------------- Testing

map("n", "<Plug>L1 S, R1 O", ":so<cr>")

--------------------------------------------------------------------------------- Surround

map("n", "<Plug>L1 S, R1 J", "ysiw}", { remap = true })
map("n", "<Plug>L1 S, R1 K", "ysiw)", { remap = true })

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
