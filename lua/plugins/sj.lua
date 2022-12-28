return {
	"woosaaahh/sj.nvim",
	config = function()
		local sj = require("sj")
		sj.setup({
			auto_jump = true,
			separator = "",
		})

		local function jump()
			vim.cmd("norm! m'")
			sj.run({})
		end

		vim.keymap.set({ "n", "x" }, "s", function()
			jump()
		end)

		-- STS with SJ
		local feed = function(mapping, mode)
			local key = vim.api.nvim_replace_termcodes(mapping, true, false, true)
			vim.api.nvim_feedkeys(key, mode or "m", false)
		end

		-- vim.keymap.set("n", "<A-n>", function()
		-- 	jump()
		-- 	vim.cmd("norm vx")
		-- end)
		-- vim.keymap.set("n", "<A-y>", function()
		-- 	jump()
		-- 	feed("vxY<C-o>", "m")
		-- end)
		-- vim.keymap.set("n", "<A-S-y>", function()
		-- 	jump()
		-- 	feed("vny<C-o>", "m")
		-- end)

		-- vim.keymap.set("n", "<A-d>", function()
		-- 	jump()
		-- 	feed("vxD<C-o>", "m")
		-- end)
	end,
}
