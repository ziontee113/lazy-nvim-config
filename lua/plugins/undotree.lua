return {
    "mbbill/undotree",
    branch = "search",
    config = function()
        vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true })
    end,
    cmd = { "UndotreeShow", "UndotreeToggle" },
    keys = { "<leader>u" },
}
