vim.keymap.set("n", "<C-p>", ":G push<CR>", { buffer = 0 })
vim.keymap.set("n", "q", ":q<cr>", { buffer = 0 })

-- Staging Remaps
vim.keymap.set("n", "S", "5ggs", { buffer = 0, remap = true })
vim.keymap.set("n", "U", "5ggu", { buffer = 0, remap = true })
