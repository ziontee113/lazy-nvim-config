return {
    "NvChad/nvim-colorizer.lua",
    config = {
        filetypes = {
            "*", -- Highlight all files, but customize some others.
            typescriptreact = { mode = "background", tailwind = true },
            svelte = { mode = "background", tailwind = true },
            rust = { mode = "foreground", tailwind = true },
        },
    },
}
