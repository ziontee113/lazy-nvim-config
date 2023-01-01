local o = vim.opt

o.number = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true
o.wrap = false

o.scrolloff = 4

o.splitright = true
o.splitbelow = true

o.cursorline = true

o.fileencoding = "utf-8"
o.termguicolors = true

o.swapfile = false
o.undofile = true

o.ignorecase = true
o.smartcase = true

vim.g.mapleader = " "

vim.cmd([[set clipboard+=unnamedplus]])
vim.cmd([[au BufEnter * :set formatoptions-=cro]])
vim.cmd([[set nohlsearch]])

vim.cmd("set signcolumn=yes:1")
vim.cmd("set statusline=%{repeat('─',winwidth('.'))}")

o.laststatus = 0
o.cmdheight = 0
