local rm = require("scripts.remote_mapping")

---------------------------------------------------------------------------------

local function create_server(host, port, on_connect)
    local server = vim.loop.new_tcp()

    server:bind(host, port)

    server:listen(128, function()
        local sock = vim.loop.new_tcp()
        server:accept(sock)
        on_connect(sock)
    end)

    return server
end

local server = create_server("0.0.0.0", 0, function(sock)
    sock:read_start(function(_, chunk)
        if chunk then
            rm.handle_remote_input(chunk)
            sock:write(chunk)
        else
            sock:close()
        end
    end)
end)

local nvim_port = server:getsockname().port

---------------------------------------------------------------------------------

local tcp_augroup = vim.api.nvim_create_augroup("Kluster_TCP", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
    pattern = "*",
    group = tcp_augroup,
    callback = function()
        local client = vim.loop.new_tcp()
        vim.loop.tcp_connect(client, "0.0.0.0", 3333, function()
            vim.loop.write(client, tostring(nvim_port))
            vim.loop.shutdown(client)
        end)
    end,
})
