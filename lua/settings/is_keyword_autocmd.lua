local augroup = vim.api.nvim_create_augroup("iskeyword", {})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        vim.cmd("set iskeyword-=_")
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        vim.cmd("set iskeyword+=_")
    end,
})
