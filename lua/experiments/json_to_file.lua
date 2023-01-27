local my_table = {
    name = "John",
    age = 21,
}

local encoded_json = vim.fn.json_encode(my_table)

N(encoded_json)

-- {{{nvim-execute-on-save}}}
