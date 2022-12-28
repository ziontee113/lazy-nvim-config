return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	cmd = "Telescope",
	keys = {
		{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Telescope find_files" },
		{ "<C-g>", "<cmd>Telescope live_grep<cr>", desc = "Telescope live_grep" },
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				dynamic_preview_title = true,
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-l>"] = actions.select_default,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
				},
				lsp_dynamic_workspace_symbols = {
					file_ignore_patterns = { "node_modules/" },
				},
			},
		})
	end,
}
