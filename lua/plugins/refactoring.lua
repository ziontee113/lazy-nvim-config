return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
    },
    keys = {
        -- Remaps for the refactoring operations currently offered by the plugin
        {
            mode = "x",
            "<leader>re",
            [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        },
        {
            mode = "x",
            "<leader>rf",
            [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        },
        {
            mode = "v",
            "<leader>rv",
            [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        },
        {
            mode = "v",
            "<leader>ri",
            [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        },

        -- Extract block doesn't need visual mode
        {
            mode = "n",
            "<leader>rb",
            [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
        },
        {
            mode = "n",
            "<leader>rbf",
            [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        },

        -- Inline variable can also pick up the identifier currently under the cursor without visual mode
        {
            mode = "n",
            "<leader>ri",
            [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        },
    },
    config = function()
        require("refactoring").setup({})
    end,
}
