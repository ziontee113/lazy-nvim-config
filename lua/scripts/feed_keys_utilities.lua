local M = {}

M.feed = function(mapping, mode)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, mode or "m", false)
end

M.type_insert = function(mapping)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, "Rns", false)
end

M.input = function(mapping)
    vim.api.nvim_input(mapping)
end

M.mark = function(mark_name)
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_mark(0, mark_name or "'", cursor[1], cursor[2], {})
end

return M
