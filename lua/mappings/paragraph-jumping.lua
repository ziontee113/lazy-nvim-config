-- local function handle_top_bottom_line_jump(jumpCmd)
--     vim.cmd(jumpCmd)
--     local curLine = vim.api.nvim_win_get_cursor(0)[1]
--     if curLine == 2 then
--         vim.cmd("normal! k")
--     elseif curLine + 1 == vim.api.nvim_buf_line_count(0) then
--         if jumpCmd == "keepjumps normal! j}k" then
--             vim.cmd("normal! j")
--         end
--     end
-- end

-- vim.keymap.set({ "n", "x", "o" }, "<C-j>", function()
--     handle_top_bottom_line_jump("keepjumps normal! j}k")
-- end)
-- vim.keymap.set({ "n", "x", "o" }, "<C-k>", function()
--     handle_top_bottom_line_jump("keepjumps normal! k{j")
-- end)

vim.keymap.set({ "n", "x", "o" }, "<A-h>", function()
    vim.cmd("keepjumps normal! {")
end)
vim.keymap.set({ "n", "x", "o" }, "<A-l>", function()
    vim.cmd("keepjumps normal! }")
end)
