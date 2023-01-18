-- Switch Tab
vim.keymap.set("n", "zp", function()
    vim.cmd("tabprev")
end, {})
vim.keymap.set("n", "zn", function()
    vim.cmd("tabnext")
end, {})

-- Jump list relative line jump
vim.keymap.set("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'gj']], { expr = true })
vim.keymap.set("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'gk']], { expr = true })

-- Select word under cursor
vim.keymap.set("n", "vv", "viw", {})

-- Press <C-/> for inputting "_"
vim.keymap.set({ "i", "s" }, "<A-/>", "_")

-- Move to beginning of line
vim.keymap.set({ "n", "x", "o" }, "0", "^")
vim.keymap.set({ "n", "x", "o" }, ")", "0")

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
vim.keymap.set("n", "<F12>", "1gt<cmd>mks!<cr>:qa!<cr>")
vim.keymap.set("n", "<F11>", function()
    if vim.o.cmdheight == 0 then
        vim.o.cmdheight = 1
    else
        vim.o.cmdheight = 0
    end
end, { desc = "toggle cmdheiht" })

------------------------------------------------------ Arsham's Mappings

-- "keep the visually selected area when indenting"
vim.keymap.set("x", "<", "<gv", { desc = "keep Visual Mode when <" })
vim.keymap.set("x", ">", ">gv", { desc = "keep Visual Mode when >" })

vim.keymap.set("n", "g=", "gg=Gg``", { desc = "re-indent entire buffer" })
vim.keymap.set("n", "<C-e>", "2<C-e>")
vim.keymap.set("n", "<C-y>", "2<C-y>")

-- "auto re-centre when moving around"
vim.keymap.set("n", "G", function()
    vim.o.lazyredraw = true
    vim.cmd("norm! Gzz")
    vim.o.lazyredraw = false
end)
vim.keymap.set("n", "g;", "m'g;zz", { desc = "next position in change list" })
vim.keymap.set("n", "g,", "m'g,zz", { desc = "prev position in change list" })

vim.keymap.set("x", "p", '"_dP', { desc = "don't replace register when pasting" })

-- Local List related
vim.keymap.set("n", "<leader>gw", ":silent lgrep <word> % <CR>")

-- spelling
vim.keymap.set("n", "<leader>sp", function()
    vim.wo.spell = not vim.wo.spell
end, { desc = "toggle spelling" })
vim.keymap.set("n", "<leader>sf", function()
    local spell = vim.wo.spell
    vim.wo.spell = true
    vim.api.nvim_input("[s1z=``")
    vim.schedule(function()
        vim.wo.spell = spell
    end)
end, { desc = "fix spelling" })

-- show help tags under cursor or visual selection
vim.keymap.set("n", "<leader>hh", ":h <CR>")
vim.keymap.set("x", "<leader>hh", 'y:h "<CR>')

vim.keymap.set("n", "cn", "*``cgn")
vim.keymap.set("x", "C", function()
    vim.api.nvim_input('y/"<CR>Ncgn')
end, { silent = true })

-- Make the last change as an initiation for cgn.
vim.keymap.set("n", "g.", [[/\V<C-r>"<CR>cgn<C-a><Esc>]])

-- Insert mode enhancements
vim.keymap.set("i", "<C-u>", "<C-g>u<C-u>")
vim.keymap.set("i", "<C-w>", "<C-g>u<C-w>")
vim.keymap.set("i", "<M-e>", "<C-g>u<C-o>D")
vim.keymap.set("i", "<M-a>", "<C-g>u<C-o>de")

local keys = { ".", ";", "," }
for _, key in ipairs(keys) do
    vim.keymap.set("i", key, key .. "<C-g>u")
end

-- Command Mode
vim.keymap.set("c", "<M-a>", "<home>")
vim.keymap.set("c", "<M-e>", "<end>")

-- Exchange windows
vim.keymap.set("n", "<C-w>y", function()
    local window = vim.api.nvim_win_get_number(0)
    local buffer = vim.api.nvim_buf_get_number(0)
    vim.keymap.set("n", "<C-w>x", function()
        local view = vim.fn.winsaveview()
        local cur_buf = vim.api.nvim_buf_get_number(0)
        local cur_win = vim.api.nvim_win_get_number(0)
        vim.cmd.buffer(buffer)
        vim.api.nvim_command(tostring(window) .. "wincmd w")
        vim.cmd.buffer(cur_buf)
        vim.api.nvim_command(tostring(cur_win) .. "wincmd w")
        vim.fn.winrestview(view)
        vim.keymap.del("n", "<C-w>x")
    end, { desc = "swap picked window" })
end, { desc = "choose window to swap back to when pressing <C-w>x" })

vim.keymap.set("n", "<leader>ch", function()
    local height = vim.opt.cmdheight:get()
    if height == 0 then
        height = 1
    else
        height = 0
    end
    vim.opt.cmdheight = height
end, { desc = "toggle cmdheight" })

vim.keymap.set("n", "<leader>sb", function()
    vim.opt_local.scrollbind = not vim.opt_local.scrollbind:get()
end, { desc = "scrollbind current window" })

vim.keymap.set("x", "/", "<Esc>/\\%V", { desc = "Search in visually selected region" })

-- {{{nvim-execute-on-save}}}
