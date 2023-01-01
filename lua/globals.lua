RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(...)
    RELOAD(...)
    return require(...)
end
