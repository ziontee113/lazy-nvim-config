local feed_keys_utilities = require("scripts.feed_keys_utilities")
local feed = feed_keys_utilities.feed
local type_insert = feed_keys_utilities.type_insert
local mark = feed_keys_utilities.mark
local input = feed_keys_utilities.input

---------------------------------------------------------------------------------

USER_MAPPINGS = {}

REMAP = function(mode, mapping, callback, opts)
    local modified_opts = opts or {}
    modified_opts.silent = modified_opts.silent or true

    vim.keymap.set(mode, mapping, callback, modified_opts)

    if not vim.tbl_contains(USER_MAPPINGS, mapping) then
        table.insert(USER_MAPPINGS, mapping)
    end
end

---------------------------------------------------------------------------------

PENDING_KEY_LITERAL = nil
local literal_emitter_mapping = "R1 M, L1 A"
REMAP("i", "<Plug>" .. literal_emitter_mapping .. "<Plug>", function()
    if PENDING_KEY_LITERAL then
        feed(PENDING_KEY_LITERAL)
    end
end)

--------------------------------------------------------------------------------- Find Brackets --- Feels kinda useless

REMAP({ "n", "x" }, "<Plug>L1 F, R1 J<Plug>", "/[{}]<cr>")
REMAP({ "n", "x" }, "<Plug>L1 F, R1 H<Plug>", "?[{}]<cr>")

REMAP({ "n", "x" }, "<Plug>L1 F, R1 L<Plug>", "?[()]<cr>")
REMAP({ "n", "x" }, "<Plug>L1 F, R1 K<Plug>", "/[()]<cr>")

REMAP({ "n", "x" }, "<Plug>L1 F, L1 Q<Plug>", [=[?['"]<cr>]=])
REMAP({ "n", "x" }, "<Plug>L1 F, L1 W<Plug>", [=[/['"]<cr>]=])

--------------------------------------------------------------------------------- Crazy Combos

REMAP("n", "<Plug>L1 D, R1 J, !L1 D, L1 Q<Plug>", "<cmd>vs<cr>") -- works
REMAP("n", "<Plug>[L1 D, L1 F], R1 J, !L1 F, !L1 D, L1 Q<Plug>", "<cmd>sp<cr>") -- also works
REMAP("n", "<Plug>[L1 D, L1 F], [R1 J, R1 K], !L1 F, L1 G<Plug>", function()
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
            REMAP(
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

REMAP("n", "<Plug>L1 C, L1 B<Plug>", "cib", { remap = true })

REMAP("n", "<Plug>L1 C, R1 J<Plug>", "ci{", { remap = true })
REMAP("n", "<Plug>L1 C, R1 J, R1 H<Plug>", "cil{", { remap = true })
REMAP("n", "<Plug>L1 C, R1 J, R1 K<Plug>", "cin{", { remap = true })

REMAP("n", "<Plug>L1 C, R1 K<Plug>", "ci(", { remap = true })
REMAP("n", "<Plug>L1 C, R1 K, R1 J<Plug>", "cil(", { remap = true })
REMAP("n", "<Plug>L1 C, R1 K, R1 L<Plug>", "cin(", { remap = true })

REMAP("n", "<Plug>L1 C, R1 H<Plug>", "ciq", { remap = true })
REMAP("n", "<Plug>L1 C, R1 H, R1 J<Plug>", "cilq", { remap = true })
REMAP("n", "<Plug>L1 C, R1 H, R1 K<Plug>", "cinq", { remap = true })

--------------------------------------------------------------------------------- Select In Brackets

REMAP("n", "<Plug>L1 V, R1 J<Plug>", "vi{")
REMAP("n", "<Plug>L1 V, L1 A, R1 J<Plug>", "va{")

REMAP("n", "<Plug>L1 V, R1 K<Plug>", "vi(")
REMAP("n", "<Plug>L1 V, L1 A, R1 K<Plug>", "va(")

REMAP("n", "<Plug>L1 V, R1 H<Plug>", [[viq]], { remap = true })
REMAP("n", "<Plug>L1 V, L1 A, R1 H<Plug>", [[vaq]], { remap = true })

--------------------------------------------------------------------------------- Update User Mapping

local M = {}

M.update_user_mappings_tbl = function()
    local modes = { "n", "v", "V", "i", "s" }

    for _, mode in ipairs(modes) do
        local keymaps = vim.api.nvim_get_keymap(mode)

        for _, keymap in ipairs(keymaps) do
            local lhs = keymap.lhs
            if string.find(lhs, "<Plug>") and not vim.tbl_contains(USER_MAPPINGS, lhs) then
                table.insert(USER_MAPPINGS, lhs)
            end
        end
    end
end

REMAP("n", "<Plug>L1 S, R1 O<Plug>", function()
    vim.cmd("so")
    M.update_user_mappings_tbl()
end)

--------------------------------------------------------------------------------- Delete

REMAP("n", "<Plug>L1 D, R1 L<Plug>", "dd")

--------------------------------------------------------------------------------- Arsham's Create empty lines

local function insert_empty_lines(count, add)
    if count == 0 then
        count = 1
    end
    local lines = {}
    for i = 1, count do
        lines[i] = ""
    end
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_lines(0, pos[1] + add, pos[1] + add, false, lines)
end

REMAP("n", "<Plug>L1 Z, R1 H<Plug>", function()
    insert_empty_lines(1, -1)
end)

REMAP("n", "<Plug>L1 Z, R1 L<Plug>", function()
    insert_empty_lines(1, 0)
end)

--------------------------------------------------------------------------------- General

REMAP("n", "<Plug>L1 D, L1 W<Plug>", "<cmd>q<cr>")
REMAP("n", "<Plug>L1 V, L1 S<Plug>", "<cmd>vs<cr>")
REMAP("n", "<Plug>L1 D, R1 P<Plug>", "dap")

REMAP({ "n", "i", "x" }, "<Plug>L1 D, R1 J<Plug>", function()
    feed("<ESC>")
end)

--------------------------------------------------------------------------------- Surround

REMAP("n", "<Plug>L1 S, R1 J<Plug>", "ysiw}", { remap = true })
REMAP("n", "<Plug>L1 S, R1 K<Plug>", "ysiw)", { remap = true })

---------------------------------------------------------------------------------

M.handle_remote_input = function(remote_input)
    local mapping = "<Plug>" .. remote_input .. "<Plug>"

    if vim.tbl_contains(USER_MAPPINGS, mapping) then
        input(mapping)
    end

    if remote_input ~= literal_emitter_mapping then
        PENDING_KEY_LITERAL = mapping
    end
end

M.update_user_mappings_tbl()

return M
