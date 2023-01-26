local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

local opts = {
    prompt_title = "My Dotfiles",
    search_dirs = { "~/dotfiles/" },
    shorten_path = true,
}
builtin.find_files(opts)
