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

cs({
    trigger = "simple_return",
    nodes = fmt(
        [=[
export default function {}() {{
  return {};
}}
]=],
        {
            i(1, "Gallery"),
            i(2, "\"Hello World!\""),
        }
),
    target_table = snippets,
})

cs({
    trigger = "comment",
    nodes = fmt(
        [=[
{{{}}}
]=],
        {
            i(1, "/* Images will go here */"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "useState",
    nodes = fmt(
        [=[
const [{}, {}] = useState({});
]=],
        {
            i(1, "isLoading"),
            i(2, "setLoading"),
            i(3, "true"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "function",
    nodes = fmt(
        [=[
function {}({}: {}) {{
  {}
}}
]=],
        {
            i(1, "cn"),
            i(2, "...classes"),
            i(3, "string[]"),
            i(4, "return classes.filter(Boolean).join(\" \");"),
        }
),
    target_table = snippets,
})

cs({
    trigger = "import",
    nodes = fmt(
        [=[
import {{ {} }} from "{}";
]=],
        {
            i(1, "useState"),
            i(2, "react"),
        }
),
    target_table = snippets,
})

------------------------------------------------------------------------- Snippets goes here

return snippets, autosnippets
