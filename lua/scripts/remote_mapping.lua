local M = {}

local feed = function(mapping, mode)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, mode or "m", false)
end

local type = function(mapping)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, "Rns", false)
end

M.handle_remote_input = function(input)
    print(input)
end

return M
