return {
    "akinsho/toggleterm.nvim",
    keys = {
        { [[<C-\>]] },
    },
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<c-\>]],
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = "0",
            start_in_insert = true,
            persist_size = true,
            direction = "float",
        })
    end,
}
