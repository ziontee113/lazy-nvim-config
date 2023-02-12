---- Lazy Plugin Manager
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
require("settings.execute_on_save_autocmd")
-- require("settings.line_number_autocmd")
require("settings.cmd_abbrev")

require("lazy").setup("plugins", {
    dev = {
        path = "~/.config/dev-nvim/",
        patterns = { "ziontee113" },
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
})

---- mappings
require("mappings.basic")
require("mappings.paragraph-jumping")

---- colorscheme modifications
-- require("settings.colors")
require("settings.transparent")

---- global functions / variables
require("globals")

---- remote mapping
-- require("scripts.tcp")

---- experimenting scripts
require("special.make_lua_file")

---- dev
-- vim.cmd([[set runtimepath+=~/dev/nvim-custom-plugin/zion-kit/]])
-- require("zion-kit")

-- vim.cmd([[set runtimepath+=~/.config/dev-nvim/snippet-factory.nvim/]])
-- require("snippet-factory")

-------------------------------------------------------------------------- example.nvim

vim.cmd([[set runtimepath+=/home/ziontee113/.config/dev-nvim/MAGO.nvim/]])
require("MAGO")
vim.cmd([[set runtimepath+=/home/ziontee113/.config/dev-nvim/SnippetGenie/]])
require("SnippetGenie")
