local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local first_picker = function()
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

    local my_func = function(prompt_bufnr)
        local selected_entry = action_state.get_selected_entry()

        N(selected_entry[1])

        actions.close(prompt_bufnr)
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

    return picker
end

local picker = first_picker()
picker:find()
