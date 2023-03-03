---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: unused-local
local snippets, autosnippets = {}, {}
local luasnip_utils = require("special.luasnip-utils")
local cs = luasnip_utils.create_snippet

-------------------------------------------------------------------------

cs({
    trigger = "thread_handle_move_loop",
    nodes = fmt(
        [=[
let {} = thread::spawn(move || loop {{
{}
}});
]=],
        {
            i(1, "left_handle"),
            i(2, { "    for ev in left_kb.fetch_events().unwrap() {", "        println!(\"{ev:?}\");", "    }" }),
        }
),
    target_table = snippets,
})

cs({
    trigger = "channel",
    nodes = fmt(
        [=[
let ({}, {}) = mpsc::channel();
]=],
        {
            i(1, "tx"),
            i(2, "rx"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "clear_screen",
    nodes = fmt(
        [=[
print!("{{}}[2J", 27 as char);
]=],
        {
            
        }
),
    target_table = snippets,
})

------------------------------------------------------------------------- Snippets goes here

return snippets, autosnippets
