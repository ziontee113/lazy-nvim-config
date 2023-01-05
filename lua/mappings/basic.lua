-- Switch Tab
vim.keymap.set("n", "zp", function()
    vim.cmd("tabprev")
end, {})
vim.keymap.set("n", "zn", function()
    vim.cmd("tabnext")
end, {})

-- Jump list relative line jump
vim.keymap.set("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'j']], { expr = true })
vim.keymap.set("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'k']], { expr = true })

-- Select word under cursor
vim.keymap.set("n", "vv", "viw", {})

-- Press <C-/> for inputting "_"
vim.keymap.set({ "i", "s" }, "<A-/>", "_")

-- Move to beginning of line
vim.keymap.set("n", "0", "^")
vim.keymap.set("n", ")", "0")

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
vim.keymap.set("n", "<F8>", ":mks!<cr>")
vim.keymap.set("n", "<F9>", ":wa!<cr>")
vim.keymap.set("n", "<F12>", "gt1<cmd>mks!<cr>:qa!<cr>")
vim.keymap.set("n", "<F11>", function()
    if vim.o.cmdheight == 0 then
        vim.o.cmdheight = 1
    else
        vim.o.cmdheight = 0
    end
end)

-- {{{nvim-execute-on-save}}}
