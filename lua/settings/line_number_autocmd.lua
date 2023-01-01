local augroup = vim.api.nvim_create_augroup("Settings", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        vim.wo.relativenumber = true
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        vim.wo.relativenumber = false
    end,
})
