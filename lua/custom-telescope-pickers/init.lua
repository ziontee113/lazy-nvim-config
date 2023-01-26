local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local themes = require("telescope.themes")
local builtin = require("telescope.builtin")

local M = {}

local opts = {
    prompt_title = "My Dotfiles",
    search_dirs = { "~/dotfiles/" },
    shorten_path = true,
}
builtin.find_files(opts)