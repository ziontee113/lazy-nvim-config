vim.keymap.set("n", "<C-V>", function()
    local curline = vim.api.nvim_get_current_line()
    local working_directory = vim.fn.getcwd() .. "/"
    vim.cmd("vs")
    vim.cmd("e " .. working_directory .. curline)
end, { buffer = true, noremap = true, silent = true })

-- horizontal split (control+x)
vim.keymap.set("n", "<C-x>", function()
    local curline = vim.api.nvim_get_current_line()
    local working_directory = vim.fn.getcwd() .. "/"
    vim.cmd("sp")
    vim.cmd("e " .. working_directory .. curline)
end, { buffer = true, noremap = true, silent = true })

-- new tab (control+t)
vim.keymap.set("n", "<C-t>", function()
    local curline = vim.api.nvim_get_current_line()
    local working_directory = vim.fn.getcwd() .. "/"
    vim.cmd("tabnew")
    vim.cmd("e " .. working_directory .. curline)
end, { buffer = true, noremap = true, silent = true })
