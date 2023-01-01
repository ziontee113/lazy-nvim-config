local feed_keys_utilities = require("scripts.feed_keys_utilities")
local feed = feed_keys_utilities.feed
local type_insert = feed_keys_utilities.type_insert

---------------------------------------------------------------------------------

local user_mappings = {}

local add = function(mode, mapping, callback, opts)
    vim.keymap.set(mode, mapping, callback, opts or {})

    local raw_mapping = mapping:gsub("<Plug>", "")
    table.insert(user_mappings, raw_mapping)
end

---------------------------------------------------------------------------------

local pending_key_literal
local literal_emitter_mapping = "R1 M Down, L1 A Down"
add("i", "<Plug>" .. literal_emitter_mapping, function()
    if pending_key_literal then
        feed("<Plug>" .. pending_key_literal)
    end
end)

---------------------------------------------------------------------------------

add("n", "<Plug>L1 R Down, R1 L Down", function()
    R("scripts.tcp")
    R("scripts.remote_mapping")
end)

add("i", "<Plug>L1 R Down, R1 L Down", function()
    type_insert("super idol something samala")
end)

add("i", "<Plug>L1 D Down, R1 J Down", function()
    type_insert("super idol")
end)

add("n", "<Plug>L1 D Down, R1 J Down", function()
    feed("<cmd>Telescope help_tags<cr>")
end)

---------------------------------------------------------------------------------

local M = {}

M.handle_remote_input = function(input)
    if vim.tbl_contains(user_mappings, input) then
        feed("<Plug>" .. input)
    end

    if input ~= literal_emitter_mapping then
        pending_key_literal = input
    end
end

return M
