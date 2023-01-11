N = function(message, level, title)
    if type(message) ~= "string" then
        message = vim.inspect(message)
    end
    vim.notify(message, level or "info", { title = title })
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(...)
    RELOAD(...)
    return require(...)
end
