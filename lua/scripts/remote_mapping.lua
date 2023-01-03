local feed_keys_utilities = require("scripts.feed_keys_utilities")
local feed = feed_keys_utilities.feed
local type_insert = feed_keys_utilities.type_insert

---------------------------------------------------------------------------------

USER_MAPPINGS = {}

local map = function(mode, mapping, callback, opts)
    local modified_opts = opts or {}
    modified_opts.silent = true

    vim.keymap.set(mode, mapping, callback, modified_opts)

    local raw_mapping = mapping:gsub("<Plug>", ""):gsub("", "")

    if not vim.tbl_contains(USER_MAPPINGS, raw_mapping) then
        table.insert(USER_MAPPINGS, raw_mapping)
    end
end

---------------------------------------------------------------------------------

PENDING_KEY_LITERAL = nil
local literal_emitter_mapping = "R1 M, L1 A"
map("i", "<Plug>" .. literal_emitter_mapping .. "", function()
    if PENDING_KEY_LITERAL then
        feed("<Plug>" .. PENDING_KEY_LITERAL .. "")
    end
end)

--------------------------------------------------------------------------------- Find Brackets --- Feels kinda useless

map({ "n", "x" }, "<Plug>L1 F, R1 J", "/[{}]<cr>")
map({ "n", "x" }, "<Plug>L1 F, R1 H", "?[{}]<cr>")

map({ "n", "x" }, "<Plug>L1 F, R1 L", "?[()]<cr>")
map({ "n", "x" }, "<Plug>L1 F, R1 K", "/[()]<cr>")

map({ "n", "x" }, "<Plug>L1 F, L1 Q", [=[?['"]<cr>]=])
map({ "n", "x" }, "<Plug>L1 F, L1 W", [=[/['"]<cr>]=])

--------------------------------------------------------------------------------- Crazy Combos

map("n", "<Plug>L1 D, R1 J, L1 D Up, L1 Q", "<cmd>vs<cr>") -- works
map("n", "<Plug>[L1 D, L1 F], R1 J, L1 F Up, L1 D Up, L1 Q", "<cmd>sp<cr>") -- also works
map("n", "<Plug>[L1 D, L1 F], [R1 J, R1 K], L1 F Up, L1 G", function()
    print("Crazy In Love!")
end) -- crazy!

--------------------------------------------------------------------------------- Relative Line Jump

local create_relative_jump_mappings = function()
    -- stylua: ignore
    local keys = {
        "Z", "X", "C", "V", "B",
        "A", "S", "D", "F", "G",
        "Q", "W", "E", "R", "T",
        "1", "2", "3", "4", "5",
    }

    local count_and_mark = function(count, key)
        return function()
            feed("m'", "n")
            feed(count .. key, "n")
        end
    end

    for count, key in ipairs(keys) do
        map({ "n", "x", "o" }, "<Plug>R1 K, L1 " .. key .. "", count_and_mark(count, "k"))
        map({ "n", "x", "o" }, "<Plug>R1 J, L1 " .. key .. "", count_and_mark(count, "j"))
    end
end

create_relative_jump_mappings()

--------------------------------------------------------------------------------- mini.ai

map("n", "<Plug>L1 C, L1 B", "cib", { remap = true })

map("n", "<Plug>L1 C, R1 J", "ci{", { remap = true })
map("n", "<Plug>L1 C, R1 J, R1 H", "cil{", { remap = true })
map("n", "<Plug>L1 C, R1 J, R1 K", "cin{", { remap = true })

map("n", "<Plug>L1 C, R1 K", "ci(", { remap = true })
map("n", "<Plug>L1 C, R1 K, R1 J", "cil(", { remap = true })
map("n", "<Plug>L1 C, R1 K, R1 L", "cin(", { remap = true })

map("n", "<Plug>L1 C, R1 H", "ciq", { remap = true })
map("n", "<Plug>L1 C, R1 H, R1 J", "cilq", { remap = true })
map("n", "<Plug>L1 C, R1 H, R1 K", "cinq", { remap = true })

--------------------------------------------------------------------------------- Select In Brackets

map("n", "<Plug>L1 V, R1 J", "vi{")
map("n", "<Plug>L1 V, L1 A, R1 J", "va{")

map("n", "<Plug>L1 V, R1 K", "vi(")
map("n", "<Plug>L1 V, L1 A, R1 K", "va(")

map("n", "<Plug>L1 V, R1 H", [[vi"]])
map("n", "<Plug>L1 V, L1 A, R1 H", [[va"]])

--------------------------------------------------------------------------------- General

map("n", "<Plug>L1 S, R1 O", ":so<cr>")
map("n", "<Plug>L1 D, L1 W", "<cmd>q<cr>")
map("n", "<Plug>L1 V, L1 S", "<cmd>vs<cr>")

--------------------------------------------------------------------------------- Surround

map("n", "<Plug>L1 S, R1 J", "ysiw}", { remap = true })
map("n", "<Plug>L1 S, R1 K", "ysiw)", { remap = true })

---------------------------------------------------------------------------------

local M = {}

M.handle_remote_input = function(input)
    if vim.tbl_contains(USER_MAPPINGS, input) then
        vim.api.nvim_input("<Plug>" .. input)
    end

    if input ~= literal_emitter_mapping then
        PENDING_KEY_LITERAL = input
    end
end

return M
