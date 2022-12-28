return {
	"ellisonleao/gruvbox.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		vim.o.background = "dark" -- or "light" for light mode
		vim.cmd([[
            colorscheme gruvbox
            hi GruvboxGreenSign guifg=#b8bb26 guibg=NONE
            hi GruvboxAquaSign guifg=#8ec07c guibg=NONE
            hi GruvboxYellowSign guifg=#fabd2f guibg=NONE
        ]])
	end,
}
