return {
    "folke/tokyonight.nvim",
    cond = false,
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[
            colorscheme tokyonight-night
            hi DiagnosticVirtualTextHint guifg=#1abc9c guibg=NONE
            hi DiagnosticVirtualTextInfo guifg=#0db9d7 guibg=NONE
            hi DiagnosticVirtualTextWarn guifg=#e0af68 guibg=NONE
            hi DiagnosticVirtualTextError guifg=#db4b4b guibg=NONE
        ]])
    end,
}
