---@diagnostic disable: undefined-global
---@diagnostic disable-next-line: unused-local
local snippets, autosnippets = {}, {}
local luasnip_utils = require("special.luasnip-utils")
local cs = luasnip_utils.create_snippet

-------------------------------------------------------------------------

cs({
    trigger = "sample",
    nodes = fmt(
        [=[
<div className="h-screen bg-gray-900 flex justify-center items-center">
  <h1 className="text-5xl font-bold mb-12 text-white">Batgirl</h1>
</div>
]=],
        {}
    ),
    target_table = snippets,
})

------------------------------------------------------------------------- Snippets goes here

return snippets, autosnippets
