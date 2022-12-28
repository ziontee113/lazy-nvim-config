return {
	dir = "~/.config/nvim-custom-plugin/color-picker/",
	keys = {
		{ "<C-c>", "<cmd>PickColor<cr>", mode = "n" },
		{ "<C-c>", "<cmd>PickColorInsert<cr>", mode = "i" },
	},
	config = function()
		require("color-picker").setup({
			["icons"] = { "ﱢ", "" },
			["border"] = "rounded",
			["keymap"] = {
				["Q"] = "<Plug>ColorPickerCloseColorPicker",
				["U"] = "<Plug>Slider5Decrease",
				["O"] = "<Plug>Slider5Increase",
			},
		})
	end,
}
