local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

M.first_picker = function()
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

    local first_picker_func = function(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)

        local selected_entries = {}
        for _, entry in ipairs(picker:get_multi_selection()) do
            table.insert(selected_entries, entry)
        end

        N(selected_entries)

        local new_tbl = {}
        for _, entry in ipairs(selected_entries) do
            for i = 1, 10, 1 do
                table.insert(new_tbl, entry[1] .. " - " .. tostring(i))
            end
        end

        local new_picker = M.second_picker(new_tbl)
        new_picker:find()

        -- actions.close(prompt_bufnr)
    end

    local opts = {
        finder = finders.new_table(my_table),
        sorter = sorters.get_generic_fuzzy_sorter({}),

        attach_mappings = function(_, map)
            map("i", "<CR>", first_picker_func)
            return true
        end,
    }

    local picker = pickers.new(layout, opts)

    return picker
end

M.second_picker = function(data_tbl)
    local layout = {
        layout_config = {
            height = 15,
            width = 60,
        },
    }

    local second_picker_func = function(prompt_bufnr)
        N(action_state.get_selected_entry()[1])

        actions.close(prompt_bufnr)
    end

    local opts = {
        finder = finders.new_table(data_tbl),
        sorter = sorters.get_generic_fuzzy_sorter({}),

        attach_mappings = function(_, map)
            map("i", "<CR>", second_picker_func)
            return true
        end,
    }

    local picker = pickers.new(layout, opts)

    return picker
end

local picker = M.first_picker()
picker:find()
