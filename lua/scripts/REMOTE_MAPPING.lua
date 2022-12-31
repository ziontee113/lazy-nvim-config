FEED = function(mapping, mode)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, mode or "m", false)
end

MY_REMOTE_MAPPINGS = {
    ["L1 D Down, R1 J Down"] = ":vs<cr>",
    ["L1 D Down, R1 K Down"] = ":q<cr>",
    -- ["L1 D Down, R1 K Down"] = function()
    --     print("hello Nick Fury")
    -- end,
}

ACTIVATE_REMOTE_MAPPING = function(mapping)
    vim.o.lazyredraw = true

    if MY_REMOTE_MAPPINGS[mapping] then
        if type(MY_REMOTE_MAPPINGS[mapping]) == "string" then
            FEED(MY_REMOTE_MAPPINGS[mapping])
        else
            MY_REMOTE_MAPPINGS[mapping]()
        end
    end

    vim.o.lazyredraw = false
end
