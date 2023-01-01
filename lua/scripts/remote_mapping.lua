local feed_keys_utilities = require("scripts.feed_keys_utilities")
local feed = feed_keys_utilities.feed

---------------------------------------------------------------------------------

local user_mappings = {}

local add = function(mode, mapping, callback, opts)
    vim.keymap.set(mode, mapping, callback, opts or {})

    local raw_mapping = mapping:gsub("<Plug>", "")
    table.insert(user_mappings, raw_mapping)
end

---------------------------------------------------------------------------------

local pending_key_literal
add("i", "<Plug>R1 M Down, L1 A Down", function()
    if pending_key_literal then
        feed("<Plug>" .. pending_key_literal)
    end
end)

---------------------------------------------------------------------------------

---------------------------------------------------------------------------------

local M = {}

M.handle_remote_input = function(input)
    if vim.tbl_contains(user_mappings, input) then
        feed("<Plug>" .. input)
    end

    if input ~= "R1 M Down, L1 A Down" then
        pending_key_literal = input
    end
end

return M
