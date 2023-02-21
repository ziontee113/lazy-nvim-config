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

-- press `l` to open file
vim.keymap.set("n", "l", function()
    vim.api.nvim_input("<CR>")
end, { buffer = true })

-- press number keys to jump to file when Harpoon is opened
local ui = require("harpoon.ui")
vim.keymap.set("n", "1", function()
    ui.nav_file(1)
end, { buffer = true })
vim.keymap.set("n", "2", function()
    ui.nav_file(2)
end, { buffer = true })
vim.keymap.set("n", "3", function()
    ui.nav_file(3)
end, { buffer = true })
vim.keymap.set("n", "4", function()
    ui.nav_file(4)
end, { buffer = true })
