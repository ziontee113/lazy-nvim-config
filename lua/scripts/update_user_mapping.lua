local M = {}

M.update_user_mappings_tbl = function(bufnr)
    local modes = { "n", "v", "V", "i", "s" }

    for _, mode in ipairs(modes) do
        local keymaps
        if not bufnr then
            keymaps = vim.api.nvim_get_keymap(mode)
        else
            keymaps = vim.api.nvim_buf_get_keymap(bufnr, mode)
        end

        for _, keymap in ipairs(keymaps) do
            local lhs = keymap.lhs
            if string.find(lhs, "<Plug>") and not vim.tbl_contains(USER_MAPPINGS, lhs) then
                table.insert(USER_MAPPINGS, lhs)
            end
        end
    end
end

---------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup("Update Buffer User Mappings", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        M.update_user_mappings_tbl(0)
    end,
})

return M
