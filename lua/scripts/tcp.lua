local function create_server(host, port, on_connect)
    local server = vim.loop.new_tcp()
    server:bind(host, port)
    server:listen(128, function(err)
        assert(not err, err) -- Check for errors.
        local sock = vim.loop.new_tcp()
        server:accept(sock) -- Accept client connection.
        on_connect(sock) -- Start reading messages.
    end)
    return server
end

local server = create_server("0.0.0.0", 0, function(sock)
    sock:read_start(function(_, chunk)
        if chunk then
            -- TODO: something with chunk
            print(chunk)

            sock:write(chunk) -- Echo received messages to the channel.
        else -- EOF (stream closed).
            sock:close() -- Always close handles to avoid leaks.
        end
    end)
end)

local nvim_port = server:getsockname().port

---------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup("Kluster_TCP", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
    pattern = "*",
    group = augroup,
    callback = function()
        local client = vim.loop.new_tcp()
        vim.loop.tcp_connect(client, "0.0.0.0", 3333, function()
            vim.loop.write(client, tostring(nvim_port))
            vim.loop.shutdown(client)
        end)
    end,
})
