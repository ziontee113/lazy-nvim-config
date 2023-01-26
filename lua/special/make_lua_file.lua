local myfunc = function()
    local result = vim.api.nvim_tabpage_list_wins(0)

    N(vim.inspect(result))
end

vim.keymap.set("n", "<leader>x", function()
    myfunc()
end, {})

-- {{{nvim-execute-on-save}}}
