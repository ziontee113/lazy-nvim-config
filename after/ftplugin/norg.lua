local augroup = vim.api.nvim_create_augroup("Neorg augroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.norg",
    group = augroup,
    callback = function()
        vim.wo.foldlevel = 0
        vim.wo.conceallevel = 2
        vim.wo.concealcursor = "n"

        vim.api.nvim_input("zR")
    end,
})
