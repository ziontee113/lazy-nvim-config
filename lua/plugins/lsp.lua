return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.rustywind,
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Code Formatting (from null-ls)
			local LspFormattingAugroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(client)
						return client.name == "null-ls" or client.name == "svelte"
					end,
				})
			end

			-- On LSP Server Attach
			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<a-m>", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)

				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<A-,>", vim.lsp.buf.code_action, bufopts)

				vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)

				vim.keymap.set("n", "<A-j>", vim.diagnostic.goto_next)
				vim.keymap.set("n", "<A-k>", vim.diagnostic.goto_prev)

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = LspFormattingAugroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = LspFormattingAugroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- Language Servers
			local lspconfig = require("lspconfig")

			-- Generic Settings
			local generic_servers = { "svelte", "tailwindcss" }
			for _, server in ipairs(generic_servers) do
				lspconfig[server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			-- Lua
			lspconfig.sumneko_lua.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim", "describe", "before_each", "after_each", "it" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = {
								-- "/home/ziontee113/.config/nvim-custom-plugin/zion-kit/",
							},
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	},
}
