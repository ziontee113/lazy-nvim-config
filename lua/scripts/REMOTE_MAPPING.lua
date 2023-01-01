---@diagnostic disable: unused-local, unused-function

local feed = function(mapping, mode)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, mode or "m", false)
end

local type = function(mapping)
    local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
    vim.api.nvim_feedkeys(key, "Rns", false)
end

vim.keymap.set("n", "<Plug>L1 D Down, R1 J Down", function()
    print("hello world!")
end, {})

vim.keymap.set("i", "<Plug>L1 D Down, R1 J Down", function()
    type("shut down")
end, {})

vim.keymap.set("i", "<Plug>L1 D Down, R1 K Down", function()
    type("typa girl")
end, {})

vim.keymap.set("n", "<Plug>L1 S Down, R1 O Down", function()
    vim.cmd(":so")
end, {})

vim.keymap.set("n", "<Plug>L1 1 Down, R1 J Down", function()
    print("dumb stuff")
end, {})

vim.keymap.set("n", "<Plug>L1 D Down, R1 L Down", function()
    vim.cmd(":q")
end, {})

vim.keymap.set("n", "<Leader><Plug>L1 D Down, R1 L Down", function()
    print("leader plus d l")
end, {})

vim.keymap.set("n", ",<Plug>L1 D Down, R1 L Down", function()
    print(", plus d l")
end, {})
