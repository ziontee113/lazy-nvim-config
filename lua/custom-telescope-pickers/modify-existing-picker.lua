local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

local get_entries = function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)

    local selected_entries = {}
    for _, entry in ipairs(picker:get_multi_selection()) do
        table.insert(selected_entries, entry[1])
    end

    if #selected_entries == 0 then
        table.insert(selected_entries, action_state.get_selected_entry()[1])
    end

    return selected_entries
end

local picker_func = function(prompt_bufnr)
    local selected_entries = get_entries(prompt_bufnr)

    N(selected_entries)

    actions.close(prompt_bufnr) -- also prevent picker's default behavior
end

local opts = {
    prompt_title = "My Dotfiles",
    search_dirs = { "~/dotfiles/" },
    shorten_path = true,

    attach_mappings = function(_, map)
        map("i", "<CR>", picker_func)
        return true
    end,
}
builtin.find_files(opts)
