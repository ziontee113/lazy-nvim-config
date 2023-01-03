local feed_keys_utilities = require("scripts.feed_keys_utilities")
local feed = feed_keys_utilities.feed
local type_insert = feed_keys_utilities.type_insert
local mark = feed_keys_utilities.mark
local input = feed_keys_utilities.input

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

map({ "n", "x" }, "<Plug>L1 F, R1 J<Plug>", "/[{}]<cr>")
map({ "n", "x" }, "<Plug>L1 F, R1 H<Plug>", "?[{}]<cr>")

map({ "n", "x" }, "<Plug>L1 F, R1 L<Plug>", "?[()]<cr>")
map({ "n", "x" }, "<Plug>L1 F, R1 K<Plug>", "/[()]<cr>")

map({ "n", "x" }, "<Plug>L1 F, L1 Q<Plug>", [=[?['"]<cr>]=])
map({ "n", "x" }, "<Plug>L1 F, L1 W<Plug>", [=[/['"]<cr>]=])

--------------------------------------------------------------------------------- Crazy Combos

map("n", "<Plug>L1 D, R1 J, !L1 D, L1 Q<Plug>", "<cmd>vs<cr>") -- works
map("n", "<Plug>[L1 D, L1 F], R1 J, !L1 F, !L1 D, L1 Q<Plug>", "<cmd>sp<cr>") -- also works
map("n", "<Plug>[L1 D, L1 F], [R1 J, R1 K], !L1 F, L1 G<Plug>", function()
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

    local mark_and_input = function(count, key)
        return function()
            mark()
            input(count .. key)
            return ""
        end
    end

    for count, key in ipairs(keys) do
        for _, mapping in ipairs({ "k", "j" }) do
            map(
                { "n", "x", "o" },
                "<Plug>R1 " .. string.upper(mapping) .. ", L1 " .. key .. "<Plug>",
                mark_and_input(count, mapping),
                { expr = true }
            )
        end
    end
end

create_relative_jump_mappings()

--------------------------------------------------------------------------------- mini.ai

map("n", "<Plug>L1 C, L1 B<Plug>", "cib", { remap = true })

map("n", "<Plug>L1 C, R1 J<Plug>", "ci{", { remap = true })
map("n", "<Plug>L1 C, R1 J, R1 H<Plug>", "cil{", { remap = true })
map("n", "<Plug>L1 C, R1 J, R1 K<Plug>", "cin{", { remap = true })

map("n", "<Plug>L1 C, R1 K<Plug>", "ci(", { remap = true })
map("n", "<Plug>L1 C, R1 K, R1 J<Plug>", "cil(", { remap = true })
map("n", "<Plug>L1 C, R1 K, R1 L<Plug>", "cin(", { remap = true })

map("n", "<Plug>L1 C, R1 H<Plug>", "ciq", { remap = true })
map("n", "<Plug>L1 C, R1 H, R1 J<Plug>", "cilq", { remap = true })
map("n", "<Plug>L1 C, R1 H, R1 K<Plug>", "cinq", { remap = true })

--------------------------------------------------------------------------------- Select In Brackets

map("n", "<Plug>L1 V, R1 J<Plug>", "vi{")
map("n", "<Plug>L1 V, L1 A, R1 J<Plug>", "va{")

map("n", "<Plug>L1 V, R1 K<Plug>", "vi(")
map("n", "<Plug>L1 V, L1 A, R1 K<Plug>", "va(")

map("n", "<Plug>L1 V, R1 H<Plug>", [[vi"]])
map("n", "<Plug>L1 V, L1 A, R1 H<Plug>", [[va"]])

--------------------------------------------------------------------------------- General

map("n", "<Plug>L1 S, R1 O<Plug>", ":so<cr>")
map("n", "<Plug>L1 D, L1 W<Plug>", "<cmd>q<cr>")
map("n", "<Plug>L1 V, L1 S<Plug>", "<cmd>vs<cr>")

--------------------------------------------------------------------------------- Surround

map("n", "<Plug>L1 S, R1 J<Plug>", "ysiw}", { remap = true })
map("n", "<Plug>L1 S, R1 K<Plug>", "ysiw)", { remap = true })

---------------------------------------------------------------------------------

local M = {}

M.handle_remote_input = function(remote_input)
    if vim.tbl_contains(USER_MAPPINGS, remote_input) then
        input("<Plug>" .. remote_input .. "<Plug>")
    end

    if remote_input ~= literal_emitter_mapping then
        PENDING_KEY_LITERAL = remote_input
    end
end

return M
