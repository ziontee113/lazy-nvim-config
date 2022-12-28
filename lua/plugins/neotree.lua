return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "\\", "<cmd>NeoTreeFloatToggle<cr>", desc = "NeoTree" },
	},
	config = function()
		require("neo-tree").setup()
	end,
}
