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

require("settings.basic")

require("lazy").setup("plugins", {
    change_detection = {
        enabled = false,
        notify = false,
    },
})

require("mappings.basic")
require("mappings.paragraph-jumping")
-- require("settings.colors")
require("settings.transparent")

require("scripts.cwd_curl")
