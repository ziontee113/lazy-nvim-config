return {
    "ellisonleao/gruvbox.nvim",
    -- cond = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.o.background = "dark" -- or "light" for light mode
        vim.cmd([[
            colorscheme gruvbox
            hi GruvboxRedSign guifg=#fb4934 guibg=NONE
            hi GruvboxOrangeSign guifg=#fe8019 guibg=NONE
            hi GruvboxBlueSign guifg=#83a598 guibg=NONE
            hi GruvboxGreenSign guifg=#b8bb26 guibg=NONE
            hi GruvboxAquaSign guifg=#8ec07c guibg=NONE
            hi GruvboxYellowSign guifg=#fabd2f guibg=NONE
        ]])
    end,
}
