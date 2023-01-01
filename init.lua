local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

---- basic Neovim settings
require("settings.basic")

require("lazy").setup("plugins", {
    change_detection = {
        enabled = false,
        notify = false,
    },
})

---- mappings
require("mappings.basic")
require("mappings.paragraph-jumping")

---- colorscheme modifications
require("settings.transparent")

---- global functions / variables
require("globals")

---- remote mapping
require("scripts.tcp")
