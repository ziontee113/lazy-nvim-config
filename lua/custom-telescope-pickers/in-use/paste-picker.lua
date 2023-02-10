local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

local target_bufnr = 0 -- could've been nicer, but this works

local picker_func = function(prompt_bufnr)
    local path = action_state.get_selected_entry()[1]
    local lines = vim.fn.readfile(path)

    vim.api.nvim_buf_set_lines(target_bufnr, 0, -1, false, lines)

    actions.close(prompt_bufnr)
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

return function()
    target_bufnr = vim.api.nvim_get_current_buf()

    builtin.find_files(opts)
end

-- {{{nvim-execute-on-save}}}
