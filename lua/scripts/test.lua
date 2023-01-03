vim.keymap.set("n", "<Leader><Plug>L1 D, R1 L", function()
    print("leader plus d l")
end, {})

vim.keymap.set("n", ",<Plug>L1 D, R1 L", function()
    print("comma plus d l")
end, {})

vim.keymap.set("n", "<Plug>L1 D, R1 L<Plug>L1 D, R1 L", function()
    print("double trouble")
end, {})
