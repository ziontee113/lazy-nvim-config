local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local my_table = {
    "yellow",
    "orange",
    "red",
}

local layout = {
    layout_config = {
        height = 15,
        width = 60,
    },
}

local my_func = function()
    local selected = action_state.get_selected_entry()

    N(selected[1])

    actions.close()
end

local opts = {
    finder = finders.new_table(my_table),
    sorter = sorters.get_generic_fuzzy_sorter({}),

    attach_mappings = function(_, map)
        map("i", "<CR>", my_func)
        return true
    end,
}

local picker = pickers.new(layout, opts)

picker:find()
