FEED = function(mapping, mode)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, mode or "m", false)
end

MY_REMOTE_MAPPINGS = {
    ["L1 D Down, R1 J Down"] = ":vs<cr>",
    ["L1 D Down, R1 K Down"] = ":q<cr>",
    ["L1 D Down, R1 H Down"] = function()
        FEED("4k")
    end,
    ["L1 D Down, R1 L Down"] = function()
        FEED("4j")
    end,
    ["L1 D Down, R1 O Down"] = function()
        print("hello world")
    end,
}

ACTIVATE_REMOTE_MAPPING = function(mapping)
    if MY_REMOTE_MAPPINGS[mapping] then
        if type(MY_REMOTE_MAPPINGS[mapping]) == "string" then
            FEED(MY_REMOTE_MAPPINGS[mapping])
        else
            MY_REMOTE_MAPPINGS[mapping]()
        end
    end

    print("")
end
