---@diagnostic disable: unused-local

local augroup = vim.api.nvim_create_augroup("CWD_curl", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        local cwd = vim.fn.getcwd()

        vim.fn.jobstart({
            "curl",
            "-X",
            "POST",
            "127.0.0.1:7878",
            "-H",
            "Content-Type: application/JSON",
            "-d",
            '{"cwd":"' .. cwd .. '"}',
        }, {
            on_stdout = function(_, data)
                -- if data then
                --     print(vim.inspect(data))
                --     print(cwd)
                --     print('{"cwd":"' .. cwd .. '"}')
                -- end
            end,
        })
    end,
})
