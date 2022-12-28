-- Closing window
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader><leader>q", ":qa!<CR>")

-- Lazy nvim
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")

-- Saving File
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set({ "i", "s" }, "<C-s>", "<Esc>:w<CR>")

-- <C-d> <C-u>
vim.keymap.set("n", "<C-d>", function()
    vim.o.lazyredraw = true
    vim.cmd("norm! zz")
    vim.o.lazyredraw = false
end)
vim.keymap.set("n", "<C-u>", function()
    vim.o.lazyredraw = true
    vim.cmd("norm! zz")
    vim.o.lazyredraw = false
end)

-- Move Through Windows
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Save Session and Quit
vim.keymap.set("n", "<F12>", ":mks!<cr>:qa!<cr>")
