-- local function create_server(host, port, on_connect)
--     local server = vim.loop.new_tcp()
--     server:bind(host, port)
--     server:listen(128, function(err)
--         assert(not err, err) -- Check for errors.
--         local sock = vim.loop.new_tcp()
--         server:accept(sock) -- Accept client connection.
--         on_connect(sock) -- Start reading messages.
--     end)
--     return server
-- end
--
-- local server = create_server("0.0.0.0", 0, function(sock)
--     sock:read_start(function(err, chunk)
--         assert(not err, err) -- Check for errors.
--         if chunk then
--             sock:write(chunk) -- Echo received messages to the channel.
--             print(chunk)
--         else -- EOF (stream closed).
--             sock:close() -- Always close handles to avoid leaks.
--         end
--     end)
-- end)
--
-- print("TCP echo-server listening on port: " .. server:getsockname().port)

local client = vim.loop.new_tcp()
vim.loop.tcp_connect(client, "0.0.0.0", 3333, function(err)
    -- start reading the response
    vim.loop.read_start(client, function(read_err, chunk)
        -- check if there was any error reading data back, if so, close the
        -- connection and report the error.
        if read_err then
            vim.loop.close(client)
            error("failed to read data from prettierd: " .. read_err)
        end

        -- libuv will call this callback with no data and no error when it's done,
        -- so if there's data, concatenate it into the final response. Otherwise it
        -- means we're done, so invoke the `write_to_buf` to write the data back.
        if chunk then
            print(chunk)
        else
            vim.loop.close(client)
        end
    end)

    -- write the request
    vim.loop.write(client, "Where U At?")

    -- signal to the server that we're done writing the request
    vim.loop.shutdown(client)
end)
