return {
    {
        "williamboman/mason.nvim",
        config = function()
            require"mason".setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
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
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Language Servers
            local lspconfig = require("lspconfig")

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
        end
    },
}
