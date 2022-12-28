return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local border = {
			{ "╭", "FoldColumn" },
			{ "─", "FoldColumn" },
			{ "╮", "FoldColumn" },
			{ "│", "FoldColumn" },
			{ "╯", "FoldColumn" },
			{ "─", "FoldColumn" },
			{ "╰", "FoldColumn" },
			{ "│", "FoldColumn" },
		}
		local kind_icons = {
			Text = "",
			Method = "m",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		}

		cmp.setup({
			window = {
				completion = {
					border = border,
					scrollbar = "║",
				},
				documentation = {
					border = border,
					scrollbar = "║",
				},
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
					-- kind menu
					vim_item.menu = ({
						luasnip = "[LuaSnip]",
						nvim_lsp = "[LSP]",
						path = "/",
					})[entry.source.name]
					return vim_item
				end,
			},

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "nvim_lsp" },
			},

			mapping = {
				["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},

			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
		})
	end,
}
